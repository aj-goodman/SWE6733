# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:build) do |user|
      create(:profile, user:)
    end
  end

  factory(:profile) do
    location { 'Boston, MA' }
    dob { Date.today - 30.years }
    seeking { %w[Man Woman Both].sample }
    gender { %w[Man Woman].sample }
    bio { 'Hello world!' }
    looking_for { 'anything' }
  end

  factory(:adventure) do
    name { 'Climbing' }
  end
end
