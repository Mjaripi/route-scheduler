# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    organization_id { Organization.all.sample.id }
    plate { Faker::Vehicle.license_plate }

    trait :assigned do
      driver_id { Driver.not_assigned_by_organization(organization_id).sample.id }
    end
  end
end
