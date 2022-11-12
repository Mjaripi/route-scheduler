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

  VALID_ACTIONS = %w[arrival pickup].freeze
  MAX_TIME = '18:00:00 -0300'
  MIN_TIME = '09:00:00 -0300'

  validates :action, inclusion: { in: VALID_ACTIONS }, on: :create
  validates :starts_at, comparison: { less_than: :ends_at }, on: :create

  scope :by_start_at, -> (order: :asc) { order starts_at: order.to_sym }
  scope :by_organization, -> (organization) { select { |r| r.organization.name == organization } }
  scope :max_datetime, -> (date) { "#{date.to_date} #{MAX_TIME}".to_datetime }
  scope :min_datetime, -> (date) { "#{date.to_date} #{MIN_TIME}".to_datetime }

  def compact_travel_time
    hours = travel_time / 60
    minutes = travel_time % 60

    hours.positive? ? "#{hours}H #{minutes}m" : "#{minutes}m"
  end

  def compact_route_time = "#{starts_at.to_datetime.hour}:#{starts_at.to_datetime.minute} - #{ends_at.to_datetime.hour}:#{ends_at.to_datetime.minute}"
  def legible_assigned = vehicle.nil? ? 'Unassigned' : "#{vehicle.driver.full_name} / #{vehicle.plate}"
  def minutes_between_datetimes(start_date, end_date) = ((end_date - start_date) * 24 * 60).to_i
  def max_datetime = "#{ends_at.to_date} #{MAX_TIME}".to_datetime
  def min_datetime = "#{starts_at.to_date} #{MIN_TIME}".to_datetime
  def max_minutes = minutes_between_datetimes(min_datetime, max_datetime)
  def starts_at_as_progress = ( minutes_between_datetimes(min_datetime, starts_at.to_datetime) * 100 ) / max_minutes
  def ends_at_as_progress = (( minutes_between_datetimes(min_datetime, ends_at.to_datetime) * 100 ) / max_minutes ) - starts_at_as_progress

  def route_colision?(route_to_check)
    return true if starts_at <= route_to_check.starts_at && ends_at >= route_to_check.ends_at
    return true if starts_at >= route_to_check.starts_at && ends_at <= route_to_check.ends_at
    return true if starts_at <= route_to_check.starts_at && ends_at >= route_to_check.starts_at
    return true if starts_at <= route_to_check.ends_at && ends_at >= route_to_check.ends_at

    false
  end
end
