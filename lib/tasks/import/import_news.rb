namespace :import do
  def import_news
    bad_news = []
    Post.destroy_all
    News.all.each do |new|
      puts "[#{new.id}] #{new.slug} [#{new.links.uniq.join(',')}] "
      tags = new.links.uniq.join(',')
      Post.create(slug: new.slug, title: new.title, content: new.content, portal_list: tags) rescue bad_news.push new
      hr
    end
    puts "#{bad_news.count} bad news: " + bad_news.map { |b| b.id }.join(',') if bad_news.any?

  end
end