module Jekyll
  class WikiLinks < Jekyll::Generator
    safe true
    priority :normal

    def generate(site)
      site.pages.each { |page| process_page(page, site) }
      site.posts.docs.each { |post| process_page(post, site) }
      site.collections['notes'].docs.each { |note| process_page(note, site) }
    end

    private

    def process_page(page, site)
      return unless page.content
      return if page.data['content-type'] == 'static' # Skip static pages like contact
      
      # Only process the main content
      if page.respond_to?(:content) && page.content.is_a?(String)
        # Skip processing if content contains Liquid tags (like {% include %})
        return if page.content.include?('{%') || page.content.include?('{{')
        
        # Check if this page has wiki links
        if page.content.include?('[[')
          # Process external links first ([[Title::URL]])
          page.content = process_external_links(page.content)
          
          # Process internal wiki links ([[Note Title]])
          page.content = process_internal_links(page.content, site)
        end
      end
    end

    def process_external_links(content)
      # Replace [[Title::URL]] with <a href="URL" target="_blank" rel="noopener">Title</a>
      content.gsub(/\[\[([^:\]]+)::([^\]]+)\]\]/) do |match|
        title = $1.strip
        url = $2.strip
        "<a href=\"#{url}\" target=\"_blank\" rel=\"noopener\" class=\"external-link\">#{title}</a>"
      end
    end

    def process_internal_links(content, site)
      # Get all available titles and URLs with excerpts
      all_items = []
      
      # Add notes (only the ones that are included in site.notes)
      site.collections['notes'].docs.each do |note|
        excerpt = generate_excerpt(note.content)
        url = determine_note_url(note)
        all_items << { 
          title: note.data['title'], 
          url: url,
          excerpt: excerpt
        }
      end
      
      # Add posts
      site.posts.docs.each do |post|
        excerpt = generate_excerpt(post.content)
        all_items << { 
          title: post.data['title'], 
          url: post.url,
          excerpt: excerpt
        }
      end
      
      # Add pages
      site.pages.each do |page|
        if page.data['title'] && page.data['title'] != ''
          excerpt = generate_excerpt(page.content)
          all_items << { 
            title: page.data['title'], 
            url: page.url,
            excerpt: excerpt
          }
        end
      end

      # Process each wiki link
      content.gsub(/\[\[([^\]]+)\]\]/) do |match|
        link_text = $1.strip
        found_item = find_best_match(link_text, all_items)
        
        if found_item
          # Found the note/post/page
          "<a href=\"#{site.config['baseurl']}#{found_item[:url]}\" class=\"wiki-link\" data-title=\"#{found_item[:title]}\" data-excerpt=\"#{found_item[:excerpt]}\">#{link_text}</a>"
        else
          # Note not found - create a stale link
          "<a href=\"javascript:void(0)\" class=\"stale-link\" title=\"Note not found: #{link_text}\">#{link_text}</a>"
        end
      end
    end

    def determine_note_url(note)
      # Check if note has a category that determines its URL pattern
      category = note.data['category']
      
      if category == "[[Log]]"
        # Log notes should have /log/ URLs
        filename = File.basename(note.path, '.md')
        return "/log/#{filename}"
      elsif category == "[[Projects]]"
        # Project notes should have /project/ URLs
        filename = File.basename(note.path, '.md')
        return "/project/#{filename}"
      else
        # Default to the note's actual URL
        return note.url
      end
    end

    def find_best_match(link_text, all_items)
      # First try exact case-insensitive match
      exact_match = all_items.find { |item| item[:title].downcase == link_text.downcase }
      return exact_match if exact_match
      
      # Then try partial matches (for more flexible linking)
      partial_matches = all_items.select { |item| 
        item[:title].downcase.include?(link_text.downcase) || 
        link_text.downcase.include?(item[:title].downcase)
      }
      
      # Return the best partial match (shortest title that contains the link text)
      if partial_matches.any?
        partial_matches.min_by { |item| item[:title].length }
      else
        nil
      end
    end

    def generate_excerpt(content)
      return "" unless content
      
      # Strip HTML and get first 150 characters
      excerpt = content.gsub(/<[^>]*>/, '')  # Remove HTML tags
                       .gsub(/\s+/, ' ')     # Normalize whitespace
                       .strip
      
      # Truncate to 150 characters and add ellipsis if needed
      if excerpt.length > 150
        excerpt = excerpt[0..147] + "..."
      end
      
      # Escape for HTML attributes
      excerpt.gsub('"', '&quot;').gsub("'", '&#39;')
    end
  end
end 