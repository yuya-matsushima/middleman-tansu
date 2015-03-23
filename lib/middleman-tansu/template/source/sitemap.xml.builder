---
layout: false
---
site_url = config[:sitemap_url] || "http://localhost:4567/"
xml.instruct!
xml.urlset 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.select { |page| page.destination_path =~ /\.html/ }.each do |page|
    xml.url do
      xml.loc URI.escape(File.join(site_url, page.destination_path))
      xml.lastmod Time.now.iso8601
      xml.changefreq page.data.changefreq || "weekly"
      xml.priority page.data.priority || "0.5"
    end
  end
end

