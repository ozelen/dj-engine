namespace :import do
  desc 'import the legacy db data'
  task hotelbase: :environment do

    require 'tasks/import/models/db'
    require 'tasks/import/models/pages'
    require 'tasks/import/models/classifications'
    require 'tasks/import/models/objects'
    require 'tasks/import/helpers'
    require 'tasks/import/types'
    require 'tasks/import/objects'


    ### ACTION ###

    #import_types
    import_objects

  end
end