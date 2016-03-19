
### USERS ###
User.create(	user_name: 'Bailey_Simms', 
							email: 'baileysimms96@yahoo.com', 
							password: 'temp', 
							admin: true,
							activated: true,
							activated_at: "2013-12-27 12:49:17 -0700"	)

User.create(	user_name: 'Adrian_Birch', 
							email: 'adrianbirchdib@yahoo.com', 
							password: 'temp', 
							admin: true,
							activated: true,
							activated_at: Time.zone.now	)

%w(red orange yellow green blue purple pink gray white black).each do |name|
  user_name  = "Mr_#{name.capitalize}"
  email = "#{name}@mr.com"
  password = "#{name}"
  User.create( 	user_name: user_name, 
  							email: email, 
  							password: password,
  							activated: true,
								activated_at: Time.zone.now	)
end




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

Part.create(book_id: 2, part_number: 8, title: 'Hot')
Part.create(book_id: 2, part_number: 9, title: 'Twisted')
Part.create(book_id: 2, part_number: 10, title: 'Bleeding Out')
Part.create(book_id: 2, part_number: 11, title: 'Love Is In The Air')
Part.create(book_id: 2, part_number: 12, title: 'Spread It')
Part.create(book_id: 2, part_number: 13, title: 'Falling To Pieces')
Part.create(book_id: 2, part_number: 14, title: 'Heavenly')


### RANKINGS ###

Ranking.create(name: 'top_ten_all_time')
Ranking.create(name: 'top_five_this_month')
Ranking.create(name: 'top_five_last_month')



