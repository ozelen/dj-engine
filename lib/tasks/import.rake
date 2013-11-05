namespace :import do
  desc 'import the legacy db data'
  task hotelbase: :environment do

    require 'tasks/import/models/db'
    require 'tasks/import/models/pages'
    require 'tasks/import/models/classifications'
    require 'tasks/import/models/objects'
    require 'tasks/import/models/news'
    require 'tasks/import/models/images'
    require 'tasks/import/models/agreements'
    require 'tasks/import/models/comments'
    require 'tasks/import/models/leads'
    require 'tasks/import/helpers'
    require 'tasks/import/import_types'
    require 'tasks/import/import_objects'
    require 'tasks/import/import_news'
    require 'tasks/import/import_comments'
    require 'tasks/import/reimport.rb'



    ### ACTION ###

    cold = false


    #import_types if cold

    #import_objects cold

    #import_news #if cold

    reimport_albums


  end
end