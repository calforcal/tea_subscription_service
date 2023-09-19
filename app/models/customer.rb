class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :address
  validates_uniqueness_of :email

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end