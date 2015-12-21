# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://zen.by'

SitemapGenerator::Sitemap.create do

  Page.all.includes(:menu_item, :sub_menu_item).each do |page|
    if page.menu_item.present? || page.sub_menu_item.present?
      add show_page_path(slug: page.slug)
    end
  end

  Tour.all.each do |tour|
    add show_tour_path(slug: tour.slug)
  end

  Country.all.each do |country|
    add show_country_path(slug: country.slug)
  end

  Category.all.each do |category|
    add show_category_path(slug: category.slug)
  end

  add subscribe_page_path, changefreq: 'yearly'

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.all.each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
