# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


### USERS ###
User.create(	user_name: 'Bailey_Simms', 
							email: 'baileysimms96@yahoo.com', 
							password: 'temp', 
							admin: true,
							activated: true,
							activated_at: Time.zone.now	)

# Test Users #
100.times do |n|
  user_name  = "Test_#{n+1}"
  email = "test#{n+1}@test.com"
  password = "test"
  User.create( 	user_name: user_name, 
  							email: email, 
  							password: password,
  							activated: true,
								activated_at: Time.zone.now	)
end

User.create(	user_name: 'Adrian_Birch', 
							email: 'adrianbirchdib@yahoo.com', 
							password: 'temp', 
							admin: true,
							activated: true,
							activated_at: Time.zone.now	)



### BOOKS ###

Book.create(title: 'Dead in Bed: The Complete First Book')
Book.create(title: 'Dead in Bed: The Complete Second Book')


### PARTS ###

Part.create(book_id: 1, part_number: 1, title: 'Fifty Shades of Gangrene')
Part.create(book_id: 1, part_number: 2, title: 'Stiff')
Part.create(book_id: 1, part_number: 3, title: 'Going Down Six Feet Under')
Part.create(book_id: 1, part_number: 4, title: 'Milk and Honey')
Part.create(book_id: 1, part_number: 5, title: 'Don\'t Catch the Plague')
Part.create(book_id: 1, part_number: 6, title: 'Whetted Appetites')
Part.create(book_id: 1, part_number: 7, title: 'Sick')


