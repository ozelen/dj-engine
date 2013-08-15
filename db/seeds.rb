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

Type.create(
    {
        name: 'Hotel', slug: 'hotels', filter: 'Hotel',
        field_categories_attributes: [
            {
                name: 'Dining', slug: 'catering',
                fields_attributes: [
                    {slug: 'bed-only'},
                    {slug: 'a-la-carte'},
                    {slug: 'bed-and-breakfast'},
                    {slug: 'half-board'},
                    {slug: 'full-board'},
                    {slug: 'ai'},
                    {slug: 'mini-ai'},
                    {slug: 'high-ai'},
                    {slug: 'ultra-ai'},
                    {slug: 'half-complex'},
                    {slug: 'full-complex'},
                    {slug: 'kitchen'}
                ]
            }
        ]
    }
).children.
    create([
               {slug: 'mini-hotel'},
               {slug: 'private-sector'},
               {slug: 'sanatory'},
               {slug: 'apartment'},
               {slug: 'motel'},
               {slug: 'recreation-centre'},
           ])

Type.create(
    {
        name: 'Room', slug: 'rooms', filter: 'Room',
        field_categories_attributes: [
            {
                name: 'Location', slug: 'room-placement',
                fields_attributes: [
                    {slug: 'in-main-building'},
                    {slug: 'in-bungalow'},
                    {slug: 'in-chalet'},
                    {slug: 'in-cottage'}
                ]
            },
            {
                name: 'Properties', slug: 'options',
                fields_attributes: [
                    {slug: 'cable-tv'},
                    {slug: 'satelite-tv'},
                    {slug: 'conditioner'},
                    {slug: 'minibar'},
                    {slug: 'safe'},
                    {slug: 'phone'},
                    {slug: 'dvd'},
                    {slug: 'tv'},
                    {slug: 'towels'},
                    {slug: 'fireplace'},
                    {slug: 'cabinet'}
                ]
            },
            {
                name: '', slug: '',
                fields_attributes: [
                    {slug: ''},
                ]
            }
        ]
    }
).children.
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