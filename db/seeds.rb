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
                name: 'View', slug: 'view',
                fields_attributes: [
                    {slug: 'city-view'},
                    {slug: 'beach-view'},
                    {slug: 'sea-view'},
                    {slug: 'side-sea-view'},
                    {slug: 'inside-view'},
                    {slug: 'pool-view'},
                    {slug: 'garden-view'},
                    {slug: 'ocean-view'},
                    {slug: 'land-view'},
                    {slug: 'dune-view'},
                    {slug: 'mountain-view'},
                    {slug: 'park-view'},
                    {slug: 'river-view'}
                ]
            },
            {
                name: 'Design', slug: '',
                fields_attributes: [
                    {slug: 'ethno'},
                    {slug: 'euro'},
                ]
            },
            {
                name: 'Accomodation', slug: 'accomodation',
                fields_attributes: [
                    {slug: 'sgl'},
                    {slug: 'dbl'},
                    {slug: 'dblt'},
                    {slug: 'trpl'},
                    {slug: 'qdpl'},
                    {slug: 'exb'},
                    {slug: 'inf'},
                    {slug: 'chl'},
                    {slug: 'ch'},
                    {slug: 'all'}
                ]
            },
            {
                name: 'Heating', slug: 'heating',
                fields_attributes: [
                    {slug: 'warm-floor'},
                    {slug: 'water-heating'},
                    {slug: 'steam-heating'},
                    {slug: 'electric-heating'}
                ]
            },
            {
                name: 'Layout', slug: 'layout',
                fields_attributes: [
                    {slug: 'mansard'},
                    {slug: 'balcony'},
                    {slug: 'bathroom'},
                    {slug: '1k'},
                    {slug: '2k'},
                    {slug: '3k'},
                    {slug: '4k'},
                    {slug: '2story'},
                    {slug: '3story'},
                    {slug: 'livingroom'},
                    {slug: 'kitchenroom'},
                    {slug: 'terrace'}
                ]
            },
            {
                name: 'Bathroom', slug: 'bathroom',
                fields_attributes: [
                    {slug: 'bath'},
                    {slug: 'dryer'},
                    {slug: 'shower'},
                    {slug: 'bidet'},
                    {slug: 'massage-bathtub'},
                    {slug: 'jacuzzi'},
                    {slug: 'mirror'},
                    {slug: 'warm-floor'},
                    {slug: 'washstand'}
                ]
            },
            {
                name: 'Kitchenware', slug: 'kitchenware',
                fields_attributes: [
                    {slug: 'microwave'},
                    {slug: 'kitchen'},
                    {slug: 'fridge'},
                    {slug: 'electric-kettle'},
                    {slug: 'dishes'},
                    {slug: 'glasses'}
                ]
            },
            {
                name: 'Furniture', slug: 'furniture',
                fields_attributes: [
                    {slug: 'commode'},
                    {slug: 'nightstand'},
                    {slug: 'chair'},
                    {slug: 'hanger'},
                    {slug: 'sofa'},
                    {slug: 'sofabed'},
                    {slug: 'double-bed'},
                    {slug: 'single-beds'},
                    {slug: 'single-bed'},
                    {slug: 'desktop'},
                    {slug: 'coffee-table'},
                    {slug: 'armchair'},
                    {slug: 'dressing-table'},
                    {slug: 'chair-ottoman'},
                    {slug: 'rocking-chair'}
                ]
            }
        ]
    }
).children.
    create([
               {slug: 'standard'},
               {slug: 'family-room'},
               {slug: 'superior'},
               {slug: 'studio'},
               {slug: 'suite'},
               {slug: 'junior-suite'},
               {slug: 'de-luxe'},
               {slug: 'senior-suite'},
               {slug: 'business'},
               {slug: 'honeymoon-room'},
               {slug: 'duplex'},
               {slug: 'apartment'},
               {slug: 'president'},
               {slug: 'cheap'},
               {slug: 'cottage'},
               {slug: 'house-part'},
               {slug: 'block'}
           ])


Type.create( { name: 'Following Service', slug: 'services', filter: 'Service' },
             field_categories_attributes: [
                 {
                     name: 'Price', slug: 'service-price',
                     fields_attributes: [
                         {slug: 'price'},
                         {slug: 'is-free'}
                     ]
                 }]
).children.
    create([
               {slug: 'pool'},
               {slug: 'sauna'},
               {slug: 'jacuzzi'},
               {slug: 'russian-bath'},
               {slug: 'barbecue'},
               {slug: 'pavilion'},
               {slug: 'fireplace-pavilion'},
               {slug: 'restaurant'},
               {slug: 'bar'},
               {slug: 'ski-hire'},
               {slug: 'gym'},
               {slug: 'laundry'},
               {slug: 'wifi'},
               {slug: 'conference'},
               {slug: 'parking'},
               {slug: 'cafe'},
               {slug: 'hairdressing'},
               {slug: 'stomatologist'},
               {slug: 'fastfood'},
               {slug: 'currency-exchange'},
               {slug: 'beer-pub'},
               {slug: 'ski-instructor'},
               {slug: 'transfer'},
               {slug: 'massage'},
               {slug: 'solarium'},
               {slug: 'spa'}
           ])













