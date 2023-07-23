# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ADVENTURES = ["Hiking", "Shooting", "Climbing", "Kayaking", "Whitewater Rafting", "Rock Climbing", "Biking"]
ADVENTURES.each { |a| Adventure.find_or_create_by! name: a }

LOCATIONS = ["New York, NY",
             "Kennesaw, GA",
             "Atlanta, GA",
             "Miami, FL",
             "Tallahassee, FL",
             "Boston, MA",
             "Augusta, GA",
             "Austin, TX",
             "Las Vegas, NV",
             "Westerly, RI",
             "Mystic, CT",]

LOOKING_FOR = %w[dates friends anything]

25.times do
  user = User.create!(
                         name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
                         email: Faker::Internet.email,
                         password: Faker::Internet.password
  )
  user.profile.update(
    bio: "Message me to find out!",
    location: LOCATIONS.sample,
    gender: "Woman",
    dob: Date.today - 25.years,
    looking_for: LOOKING_FOR.sample,
    seeking: ["Man", "Both"].sample,
    adventures: Adventure.all.sample(3).map(&:id)
  )
end

25.times do
  user = User.create(
    name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.profile.update(
    bio: "Message me to find out!",
    location: LOCATIONS.sample,
    gender: "Male",
    dob: Date.today - 25.years,
    looking_for: LOOKING_FOR.sample,
    seeking: ["Woman", "Both"].sample,
    adventures: Adventure.all.sample(3).map(&:id)
  )
end
