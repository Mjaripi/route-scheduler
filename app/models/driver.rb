# frozen_string_literal: true

# Model for Driver
class Driver < ApplicationRecord
  belongs_to :organization
  has_many :routes

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :first_name, :string
  attribute :last_name, :string
end
