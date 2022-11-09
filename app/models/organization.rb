# frozen_string_literal: true

# Model for Organization
class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :vehicles
  has_many :drivers

  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  attribute :name, :string
end
