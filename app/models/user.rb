class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_requests, class_name: "Friendship",
  												 foreign_key: "requestor_id",
  												 dependent: :destroy
  has_many :received_requests, class_name: "Friendship",
  												 		 foreign_key: "requested_id",
  												 		 dependent: :destroy
  has_many :requested_friends, through: :sent_requests, 		source: :requested
  has_many :accepted_friends,  through: :received_requests, source: :requestor

  has_many :posts

  def friends_with(other_user)
  	sent_and_got_accepted_by(other_user) || received_and_accepted_from(other_user)
  end

  # Sent a request to other user and other user accepted; uses friendship::accepted method
  def sent_and_got_accepted_by(other_user) #sagab
  	self.sent_requests.accepted.where(requested_id: other_user.id).exists?

  	#LEFT HERE FOR REFERENCE
  	#self.sent_requests.accepted.include?(other_user) 
  	#this is wrong, it checks the friendships for a user
  	#if i  had friends only after accept i could do self.requested_friends.include?(other_user) etc
  	#here i have to scour the friendships model
  end

  # Received a request from other_user and accepted; uses friendship::accepted method
  def received_and_accepted_from(other_user) #raaf
  	self.received_requests.accepted.where(requestor_id: other_user.id).exists?
  end

end
