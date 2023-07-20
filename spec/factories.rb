# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    after(:create) do |user|
      create(:profile, user: user)
    end
  end

  factory(:profile)
end
