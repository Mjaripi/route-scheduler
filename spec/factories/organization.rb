# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    name { "#{Faker::Company.name} #{Faker::Company.suffix}" }
  end
end
