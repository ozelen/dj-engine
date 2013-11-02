namespace :db_fix do
  desc "Delete leads with empty params"
  task :leads => :environment do
    Lead.destroy_all(params:nil)
  end

  task posts_markdown: :environment do
    I18n.locale = :uk
    Post.all.each do |post|
      puts "Editing post #{post.id}: #{post.title}"
      post.content = ReverseMarkdown.parse_string post.content
      post.save!
    end
  end

  task hotels_donated: :environment do
    I18n.locale = :uk
    Hotel.all.each do |hotel|
      hotel.donated = hotel.deals.sum(:price)
      hotel.deal_expire = hotel.deals.maximum(:expire_date) || '2006-04-20'.to_date
      hotel.save!
      puts "#{hotel.name} - donated: #{hotel.donated} expire: #{hotel.deal_expire}"
    end
  end

end
