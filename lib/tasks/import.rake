namespace :import do
  desc 'import the legacy db data'
  task hotelbase: :environment do

    require 'tasks/import/models/db'
    require 'tasks/import/models/pages'
    require 'tasks/import/models/classifications'
    require 'tasks/import/models/objects'
    require 'tasks/import/models/news'
    require 'tasks/import/helpers'
    require 'tasks/import/import_types'
    require 'tasks/import/import_objects'
    require 'tasks/import/import_news'


    ### ACTION ###

    #import_types
    #import_objects
    import_news

  end
end