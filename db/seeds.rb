# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'



# Create 10 users (id:1-5->seller, id:6-10->buyer)
10.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(10, 20),
    first_name: Faker::Internet.username,
    last_name: Faker::Internet.username
  )
end

# Create 5 restaurants
# u for seller
u = 1
5.times do
  Restaurant.create(
    name: Faker::FunnyName.two_word_name,
    address: Faker::Address.full_address,
    cuisine: Faker::Food.ingredient,
    user_id: u,
    phone_number: Faker::PhoneNumber.phone_number
  )
  u += 1
end

# Create 10 posts
# r for restaurant
r = 1
5.times do
  2.times do
    d = Faker::Number.between(0, 5)
    Post.create(
      restaurant_id: r,
      name: Faker::Food.dish,
      original_price: Faker::Number.between(30, 1000),
      discount: Faker::Number.between(0.3, 0.9),
      description: Faker::Food.description,
      start_time: Faker::Time.forward(0, :afternoon),
      end_time: Faker::Time.forward(0, :evening),
      start_day: Faker::Time.backward(d, :morning),
      end_day: Faker::Time.forward(d, :evening),
      image: Faker::Avatar.image
    )
  end
  r += 1
end

# Create 5 claims
# u2 for buyer
u2 = 6
# pid for post id
pid = 1
5.times do
  Claim.create(
    post_id: pid,
    user_id: u2
  )
  pid += 1
  u2 += 1
end
