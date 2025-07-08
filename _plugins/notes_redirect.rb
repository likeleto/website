# _plugins/notes_redirect.rb
# This plugin generates a redirect page for every /notes/:slug to /note/:slug

module Jekyll
  class NotesRedirectPage < Page
    def initialize(site, base, slug)
      @site = site
      @base = base
      @dir  = "notes"
      @name = "#{slug}.html"

      self.process(@name)
      self.data = {
        "layout" => nil,
        "sitemap" => false
      }
      self.content = <<~HTML
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="utf-8">
          <title>Redirecting…</title>
          <link rel="canonical" href="/note/#{slug}" />
          <meta http-equiv="refresh" content="0; url=/note/#{slug}" />
          <style>
            body { display: flex; align-items: center; justify-content: center; height: 100vh; background: #fff; margin: 0; }
            .refresh-icon { width: 48px; height: 48px; animation: spin 1s linear infinite; }
            @keyframes spin { 100% { transform: rotate(360deg); } }
          </style>
        </head>
        <body>
          <svg class="refresh-icon" viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="23 4 23 10 17 10"/>
            <path d="M1 20a11 11 0 0 0 17.6-1.6L23 14"/>
          </svg>
        </body>
        </html>
      HTML
    end
  end

  class NotesRedirectGenerator < Generator
    safe true
    priority :low

    def generate(site)
      notes = site.collections["notes"].docs
      notes.each do |note|
        slug = note.url.split("/").last.gsub(/\.html$/, "")
        site.pages << NotesRedirectPage.new(site, site.source, slug)
      end
    end
  end
end 