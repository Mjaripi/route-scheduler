# frozen_string_literal: true

FactoryBot.define do
  factory :route do
    organization_id { Organization.all.sample.id }
    starts_at {
      DateTime.now > "#{Date.today} 18:00:00 -0300".to_datetime ?
      Faker::Time.between(from: "#{Date.today+1} 09:00:00 -0300", to: "#{Date.today+1} 17:45:00 -0300").to_datetime :
      Faker::Time.between(from: DateTime.now, to: "#{Date.today} 17:45:00 -0300").to_datetime
    }
    ends_at {
      Faker::Time.between(from: starts_at, to: "#{starts_at.to_date} 18:00:00 -0300").to_datetime
    }
    travel_time { ( ends_at - starts_at ) * 24 * 60 }
    total_stops { 
      times = Random.rand(15..travel_time.to_i)
      travel_time%times == 0 ?
      travel_time/times :
      travel_time/times + 1
    }
    action { %w[llegada recogida].sample }

    trait :assigned do
      vehicle_id { Vehicle.assigned_by_organization(organization_id).sample.id }
    end
  end
end
