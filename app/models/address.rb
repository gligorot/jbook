class Address < ApplicationRecord
  belongs_to :profile

  validates :city, :country, presence: true
end
