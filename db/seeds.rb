# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Node.delete_all
#Node.create([
#                {name: 'home', title: "Welcome to Djerelo.Info - Hotel owner's social network", content: "Homepage", parent: 0},
#                {name: 'about', title: "About Djerelo", content: "About content", parent: 0}
#            ])
#
#User.delete_all
#User.create(username: 'oleksa', password: 'Abcd1234', email: 'ozelen@djerelo.info', first_name: 'Oleksiy', last_name: 'Zelenyuk', roles: ['admin'])

Type.delete_all
Field.delete_all

hotel = Type.create({name: 'hotel', filter: 'Hotel'})
hotel.children.
    create([
               {name: 'mini-hotel'},
               {name: 'private-sector'},
               {name: 'sanatory'},
               {name: 'apartment'},
               {name: 'motel'},
               {name: 'recreation-centre'},
           ])
hotel.fields.
    create([
               {name: 'bed-only'},
               {name: 'a-la-carte'},
               {name: 'bed-and-breakfast'},
               {name: 'half-board'},
               {name: 'full-board'},
               {name: 'ai'},
               {name: 'mini-ai'},
               {name: 'high-ai'},
               {name: 'ultra-ai'},
               {name: 'half-complex'},
               {name: 'full-complex'},
               {name: 'kitchen'}
           ])


room = Type.create({name: 'room', filter: 'Room'}).
room.children.
    create([
               {name: 'standard'},
               {name: 'family-room'},
               {name: 'superior'},
               {name: 'studio'},
               {name: 'suite'},
               {name: 'junior-suite'},
               {name: 'de-luxe'},
               {name: 'senior-suite'},
               {name: 'business'},
               {name: 'honeymoon-room'},
               {name: 'duplex'},
               {name: 'apartment'},
               {name: 'president'},
               {name: 'cheap'},
               {name: 'cottage'},
               {name: 'house-part'},
               {name: 'block'}
           ])


#in-main-building
#in-bungalow
#in-chalet
#in-cottage
#
#cable-tv
#satelite-tv
#conditioner
#minibar
#safe
#phone
#dvd
#tv
#towels
#fireplace
#cabinet
