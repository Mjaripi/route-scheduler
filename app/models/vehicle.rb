# frozen_string_literal: true

# Model for Vehicle
class Vehicle < ApplicationRecord
  belongs_to :organization
  has_many :routes

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :plate, :string

  validates :plate, uniqueness: true
end
