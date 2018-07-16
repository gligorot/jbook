class Friendship < ApplicationRecord
	belongs_to :requestor, class_name: "User"
	belongs_to :requested, class_name: "User"

	scope :accepted, 		 -> { where(accepted: true) }
	scope :accepted_nil, -> { where(accepted: nil) }
end
