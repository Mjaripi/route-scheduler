# frozen_string_literal: true

# Model for Route
class Route < ApplicationRecord
  belongs_to :organization
  belongs_to :driver
  belongs_to :vehicle

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :starts_at, :datetime
  attribute :ends_at, :datetime
  attribute :travel_time, :integer
  attribute :total_stops, :integer
  attribute :action, :string

  VALID_ACTIONS = %w[llegada recogida].freeze

  validates :action, inclusion: { in: VALID_ACTIONS }, on: :create
end
