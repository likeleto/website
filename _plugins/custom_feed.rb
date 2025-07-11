module Jekyll
  class CustomFeedGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Create a custom RSS feed for notes
      site.pages << CustomFeedPage.new(site, site.source)
    end
  end

  class CustomFeedPage < Page
    def initialize(site, base)
      @site = site
      @base = base
      @dir  = ""
      @name = "notes-feed.xml"

      self.process(@name)
      self.data = {
        "layout" => nil,
        "sitemap" => false
      }
      self.content = generate_feed_content(site)
    end

    private

    def generate_feed_content(site)
      notes = site.collections['notes'].docs
        .select { |note| note.data['feed'] == 'show' }
        .sort_by { |note| note.data['date'] || File.mtime(note.path) }
        .reverse

      # Get the last build time to determine what's "new"
      last_build_file = File.join(@site.source, '.last_build_time')
      last_build_time = if File.exist?(last_build_file)
        Time.parse(File.read(last_build_file).strip)
      else
        Time.now - (365 * 24 * 60 * 60) # 1 year ago if no previous build
      end

      # Filter notes that are "new" (created after last build)
      new_notes = notes.select do |note|
        note_date = note.data['date'] || File.mtime(note.path)
        note_date > last_build_time
      end

      # If no new notes, include the most recent ones to keep feed active
      feed_notes = new_notes.any? ? new_notes : notes.first(10)

      # Update the last build time
      File.write(last_build_file, Time.now.iso8601)

      # Generate RSS content
      generate_rss_content(site, feed_notes)
    end

    def generate_rss_content(site, notes)
      <<~XML
        <?xml version="1.0" encoding="utf-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">
          <generator uri="https://jekyllrb.com/" version="4.0.1">Jekyll</generator>
          <link href="#{site.config['url']}/notes-feed.xml" rel="self" type="application/atom+xml" />
          <link href="#{site.config['url']}/" rel="alternate" type="text/html" />
          <updated>#{Time.now.iso8601}</updated>
          <id>#{site.config['url']}/notes-feed.xml</id>
          <title type="html">#{site.config['title']} - Notes</title>
          <subtitle>#{site.config['description']}</subtitle>
          #{notes.map { |note| generate_entry(site, note) }.join("\n")}
        </feed>
      XML
    end

    def generate_entry(site, note)
      content = note.content || ""
      # Strip HTML and get first 200 characters for summary
      summary = content.gsub(/<[^>]*>/, '').strip[0..200]
      summary += "..." if content.length > 200

      # Determine the URL based on note category
      url = determine_note_url(site, note)
      
      # Use date from front matter or file modification time
      date = note.data['date'] || File.mtime(note.path)

      <<~ENTRY
          <entry>
            <title type="html">#{escape_xml(note.data['title'])}</title>
            <link href="#{site.config['url']}#{url}" rel="alternate" type="text/html" title="#{escape_xml(note.data['title'])}" />
            <published>#{date.iso8601}</published>
            <updated>#{date.iso8601}</updated>
            <id>#{site.config['url']}#{url}</id>
            <content type="html" xml:base="#{site.config['url']}#{url}">#{escape_xml(summary)}</content>
            <author>
              <name>#{site.config['title']}</name>
            </author>
          </entry>
      ENTRY
    end

    def determine_note_url(site, note)
      category = note.data['category']
      
      if category == "[[Log]]"
        filename = File.basename(note.path, '.md')
        return "/log/#{filename}"
      elsif category == "[[Projects]]"
        filename = File.basename(note.path, '.md')
        return "/project/#{filename}"
      else
        return note.url
      end
    end

    def escape_xml(text)
      text.to_s
        .gsub('&', '&amp;')
        .gsub('<', '&lt;')
        .gsub('>', '&gt;')
        .gsub('"', '&quot;')
        .gsub("'", '&#39;')
    end
  end
end 