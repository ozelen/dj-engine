domains = {
  best: 'besthotels.in.ua',
  ski:  'skiworld.org.ua'
}

domains.each do |sitename, domain|
  SitemapGenerator::Sitemap.default_host = "http://#{domain}"
  SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{domain}"
  SitemapGenerator::Sitemap.create do
    I18n.default_locale = :ru
    [:uk, :ru].map do |lang|
      locale = lang == I18n.default_locale ? nil : lang

      # add "#{lang}",      changefreq: 'daily', priority: 0.9
      # add "#{lang}/blog", changefreq: 'daily', priority: 0.9

      group sitemaps_path: "sitemaps/#{domain}/#{lang}",
            filename:      "index-#{lang}" do

        Resort.tagged_with(sitename).each do |resort|
          add slug_resort_path(resort_slug: resort.slug, locale: locale),
              lastmod:    resort.updated_at,
              changefreq: 'daily'

          group sitemaps_path: "sitemaps/#{domain}/#{lang}",
                filename:      resort.slug do

            add resort_blog_path(resort_slug: resort.slug, locale: locale),
                changefreq: 'weekly'

            resort.cities.each do |city|
              add slug_city_path(city_slug: city.slug, locale: locale),
                  lastmod:    city.updated_at,
                  changefreq: 'weekly'

              add city_hotels_path(city_slug: city.slug, locale: locale),
                  changefreq: 'monthly'
            end

            group sitemaps_path: "sitemaps/#{domain}/#{lang}/hotels",
                  filename:      "#{resort.slug}-hotels" do

              resort.hotels.by_resort.each do |hotel|
                add slug_hotel_path(hotel_slug: hotel.slug, locale: locale),
                    lastmod:    hotel.updated_at,
                    changefreq: 'monthly'
              end
            end

            group sitemaps_path: "sitemaps/#{domain}/#{lang}/posts",
                  filename:      "#{resort.slug}-posts" do

              resort.posts.each do |post|
                add resort_post_path(resort_slug: resort.slug, post_id: post.id, locale: locale),
                    lastmod:    post.updated_at,
                    changefreq: 'monthly',
                    news: {
                      publication_name:     post.name,
                      publication_language: locale,
                      title:                post.title,
                      keywords:             post.tags.join(', '),
                      publication_date:     post.updated_at,
                      genres:               "Blog"
                    }
              end
            end

          end

        end

        group sitemaps_path: "sitemaps/#{domain}/#{lang}/hotels",
              filename:      "#{sitename}-hotels" do

          Hotel.tagged_with(sitename).each do |hotel|
            add slug_hotel_path(hotel_slug: hotel.slug, locale: locale),
                lastmod:    hotel.updated_at,
                changefreq: 'weekly'

            if hotel.rooms.present?
              add slug_hotel_rooms_path(hotel_slug: hotel.slug, locale: locale)
              hotel.rooms.each do |room|
                add slug_hotel_room_path(id: room.id, hotel_slug: hotel.slug, locale: locale)
              end
            end

            add slug_hotel_services_path(hotel_slug: hotel.slug, locale: locale) if hotel.services.present?
            add slug_hotel_pricelist_path(hotel_slug: hotel.slug, locale: locale) if hotel.prices.present?
            add slug_hotel_comments_path(hotel_slug: hotel.slug, locale: locale)
            add slug_hotel_blog_path(hotel_slug: hotel.slug, locale: locale) if hotel.posts.present?
          end
        end
      end
    end

    group sitemaps_path: "sitemaps/#{domain}",
          filename:      "#{sitename}-posts" do

      Post.tagged_with(sitename).each do |post|
        add post_path(id: post.id),
            lastmod:    post.updated_at,
            changefreq: 'monthly',
            news: {
              publication_name:     post.name,
              publication_language: :ru,
              title:                post.title,
              keywords:             post.tags.join(', '),
              publication_date:     post.updated_at,
              genres:               "Blog"
            }
      end
    end

  end
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
