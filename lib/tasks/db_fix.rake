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

end
