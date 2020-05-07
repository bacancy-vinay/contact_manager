# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.destroy_all
User.destroy_all

user_ids = []
user_ids << User.create(email: "v@1.com", password: "123456").id
user_ids << User.create(email: "v@2.com", password: "123456").id
p "2 user created"

group_ids = { user_ids[0]=>[], user_ids[1]=>[] }
group_ids[user_ids[0]] << Group.create(name:"Friends", user_id: user_ids[0]).id
group_ids[user_ids[0]] << Group.create(name:"School", user_id: user_ids[0]).id
group_ids[user_ids[1]] << Group.create(name:"Family", user_id: user_ids[1]).id
group_ids[user_ids[1]] << Group.create(name:"Company", user_id: user_ids[1]).id

group_count = group_ids.length
puts "#{group_ids.count} created"

number_of_contacts = 40

contacts = []

number_of_contacts.times do 
  user_id = user_ids[Random.rand(0...2)]
  new_contact = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    company: Faker::Company.name,
    phone: Faker::PhoneNumber.cell_phone,
    address: "#{Faker::Address.street_address} #{Faker::Address.city}",
    group_id: group_ids[user_id][Random.rand(0...group_count)],
    user_id: user_id
  }
  contacts.push(new_contact)
end

Contact.create(contacts)

puts "#{number_of_contacts} contacts created"