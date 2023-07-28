# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

require "open-uri"

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

test_user = User.create!(name: "Test User", email: "test@test.com", password: "TestMe123!")

25.times do
  user = User.create!(
                         name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
                         email: Faker::Internet.email,
                         password: Faker::Internet.password
  )
  user.profile.update(
    bio: "This profile is for testing purposes only. The photo is AI generated at https://generated.photos/faces.",
    location: LOCATIONS.sample,
    gender: "Woman",
    dob: Date.today - 25.years,
    looking_for: LOOKING_FOR.sample,
    seeking: ["Man", "Both"].sample,
    adventures: Adventure.all.sample(3).map(&:id),
    accepts: [[test_user.profile.id], []].sample
  )
  user.profile.photo.attach(io: URI.parse("https://wild-fire.s3.amazonaws.com/w#{(1..5).to_a.sample}.jpeg").open, filename: "#{user.profile.id}_photo")
end

25.times do
  user = User.create(
    name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.profile.update(
    bio: "This profile is for testing purposes only. The photo is AI generated at https://generated.photos/faces.",
    location: LOCATIONS.sample,
    gender: "Man",
    dob: Date.today - 25.years,
    looking_for: LOOKING_FOR.sample,
    seeking: ["Woman", "Both"].sample,
    adventures: Adventure.all.sample(3).map(&:id),
    accepts: [[test_user.profile.id], []].sample
  )
  user.profile.photo.attach(io: URI.parse("https://wild-fire.s3.amazonaws.com/m#{(1..5).to_a.sample}.jpeg").open, filename: "#{user.profile.id}_photo")
end
