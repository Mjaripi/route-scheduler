# frozen_string_literal: true

# Model for Route
class Route < ApplicationRecord
  belongs_to :organization
  belongs_to :vehicle, required: false

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :starts_at, :datetime
  attribute :ends_at, :datetime
  attribute :travel_time, :integer
  attribute :total_stops, :integer
  attribute :action, :string

  VALID_ACTIONS = %w[llegada recogida].freeze

  validates :action, inclusion: { in: VALID_ACTIONS }, on: :create

  scope :by_organization, -> (organization) { select { |r| r.organization.name == organization } }

  def compact_travel_time
    hours = travel_time / 60
    minutes = travel_time % 60

    hours > 0 ? "#{hours}H #{minutes}m" : "#{minutes}m"
  end

  def compact_route_time = "#{starts_at.to_datetime.hour}:#{starts_at.to_datetime.minute} - #{ends_at.to_datetime.hour}:#{ends_at.to_datetime.minute}"

  def legible_assigned = vehicle.nil? ? "Unassigned" : "#{vehicle.driver.full_name} / #{vehicle.plate}"
end
