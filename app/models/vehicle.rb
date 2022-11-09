# frozen_string_literal: true

# Model for Vehicle
class Vehicle < ApplicationRecord
  belongs_to :organization
  belongs_to :driver, required: false
  has_many :routes

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :plate, :string

  validates :plate, uniqueness: true

  scope :assigned, -> { where.not(driver: nil) }
end
