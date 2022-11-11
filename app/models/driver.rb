# frozen_string_literal: true

# Model for Driver
class Driver < ApplicationRecord
  belongs_to :organization
  has_many :routes
  has_one :vehicle

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :first_name, :string
  attribute :last_name, :string

  scope :not_assigned, -> { select { |d| d.vehicle.nil? } }
  scope :assigned, -> { select { |d| !d.vehicle.nil? } }
  scope :not_assigned_by_organization, -> (organization) {  not_assigned.select { |d| d.organization.id == organization } }
  scope :enabled_drivers, -> (check_route) {
    enabled = []
    assigned.each do |driver|
      enabled << driver && next if driver.vehicle.routes.blank?
      unless check_route.vehicle.nil?
        enabled << driver && next if driver.vehicle.plate == check_route.vehicle.plate
      end
      driver.vehicle.routes.reject{ |route| route.route_colision?(check_route) }.empty? ? next : enabled << driver
    end
    enabled
  }

  def full_name = "#{first_name} #{last_name}"
  def assigned_vehicle = "#{full_name} / #{vehicle.plate}"
end
