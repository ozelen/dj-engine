namespace :db_fix do
  desc "Delete leads with empty params"
  task :leads => :environment do
    Lead.destroy_all(params:nil)
  end

end
