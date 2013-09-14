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
User.delete_all
User.create(username: 'oleksa', password: 'Abcd1234', email: 'ozelen@djerelo.info', first_name: 'Oleksiy', last_name: 'Zelenyuk', roles: ['admin'])

