# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Adding users to db"
25.times do |user|
  User.create(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.safe_email,
    password: Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true),
    coins: rand(1..100)
  )
    puts "User #{user + 1} added."
    15.times do |prod|
      Product.create(
        name: Faker::Food.unique.spice,
        description: "a simple spice",
        quantity: rand(1..20),
        category: "spice"
      )
    end
    puts "product #{prod + 1} to user."
end
puts "seed generated"

# seeds products
# name
# description
# qtt
# category
# coin_price
# tradable_for
# other_price
# negotiable


# seeds orders

