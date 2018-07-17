class Profile < ApplicationRecord
	belongs_to :user
	has_one :address, dependent: :destroy
	accepts_nested_attributes_for :address

	validates :name, :surname, :birth_date, presence: true
	#mini_bio optional
end
