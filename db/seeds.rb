# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(user_name: 'Bailey_Simms', email: 'baileysimms96@yahoo.com', password: 'temp', admin: true)

# ### TEST USERS ###
# 100.times do |n|
#   user_name  = "Test_#{n+1}"
#   email = "test#{n+1}@test.com"
#   password = "test"
#   User.create( user_name: user_name, email: email, password: password)
# end

# User.create(user_name: 'Adrian_Birch', email: 'adrianbirchdib@yahoo.com', password: 'temp', admin: true)