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
  scope :assigned, -> { reject { |d| d.vehicle.nil? } }
  scope :not_assigned_by_organization, -> (organization) {  not_assigned.select { |d| d.organization.id == organization } }

  def full_name = "#{first_name} #{last_name}"
  def assigned_vehicle = "#{full_name} / #{vehicle.plate}"
end
