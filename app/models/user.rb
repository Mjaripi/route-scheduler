# frozen_string_literal: true

# Model for Organization
class User < ApplicationRecord
  has_and_belongs_to_many :organizations

  attribute :national_id, :string
  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :national_id, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
