namespace :import do
  def import_news
    News.limit(10).each do |new|
      Post.destroy_all
      puts "#{new.slug}\n#{new.title}\n\n#{new.content}"
      #Post.create(slug: new.slug, title: new.title, content: new.content)
      # TODO: Import BookCases and NewsLinks into specific feeds
      hr
    end
  end
end