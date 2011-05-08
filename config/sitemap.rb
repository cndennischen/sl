# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.sketchlabhq.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   sitemap.add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add individual articles:
  #
  #   Article.find_each do |article|
  #     sitemap.add article_path(article), :lastmod => article.updated_at
  #   end

  sitemap.add '/public'
  sitemap.add '/signin'
  sitemap.add '/contributing'
  sitemap.add '/help'
  # Help articles
  sitemap.add '/help/overview'
  sitemap.add '/help/faq'
  sitemap.add '/help/plans'
  sitemap.add '/help/exporting'
  sitemap.add '/help/sketch_footer'
  sitemap.add '/help/quotas'
  sitemap.add '/help/searching'
end
