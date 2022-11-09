# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    organizations { Random.rand(1..3).times.map{ Organization.all.sample } }
    password { '123123123' }
    national_id { Faker::ChileRut.full_rut(min_rut: 8000000, formatted: true) }
    sequence(:email) { |n| I18n.transliterate("#{Faker::Name.first_name}+#{n}@avispa.tech").gsub(/\s+|'/, '').downcase }
  end
end
