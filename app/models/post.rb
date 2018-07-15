class Post < ApplicationRecord
	belongs_to :user
	has_many 	 :comments
	has_many   :likes

	validates :body, presence: true, length: { minimum: 3 }

	def liked_by(user)
		user.likes.where(post_id: self.id).exists?
		#this is done on purpose, to save unnecessary database queries (returning info)
	end

	def get_like(user)
		user.likes.where(post_id: self.id).first
	end

end
