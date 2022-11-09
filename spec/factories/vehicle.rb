# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    organization_id { Organization.all.sample.id }
    plate { Faker::Vehicle.license_plate }
  end
end
