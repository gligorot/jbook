class User < ApplicationRecord
  after_create :send_welcome_mail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :sent_requests, class_name: "Friendship",
  												 foreign_key: "requestor_id",
  												 dependent: :destroy
  has_many :received_requests, class_name: "Friendship",
  												 		 foreign_key: "requested_id",
  												 		 dependent: :destroy
  has_many :requested_friends, through: :sent_requests, 		source: :requested
  has_many :accepted_friends,  through: :received_requests, source: :requestor

  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_one :profile,   dependent: :destroy

  has_one :address,  through: :profile

  def friends_with(other_user)
  	sent_and_got_accepted_by(other_user) || received_and_accepted_from(other_user)
  end

  def request_exists_with(other_user)
    self.sent_request_to(other_user).exists? || self.received_request_from(other_user).exists?
  end

  # Sent a request to other user and other user accepted; uses friendship::accepted method
  def sent_and_got_accepted_by(other_user) #sagab
  	self.sent_request_to(other_user).accepted.exists?

  	#LEFT HERE FOR REFERENCE
  	#self.sent_requests.accepted.include?(other_user) 
  	#this is wrong, it checks the friendships for a user
  	#if i  had friends only after accept i could do self.requested_friends.include?(other_user) etc
  	#here i have to scour the friendships model
  end

  # Received a request from other_user and accepted; uses friendship::accepted method
  def received_and_accepted_from(other_user) #raaf
  	self.received_request_from(other_user).accepted.exists?
  end

  def sent_request_to(other_user)
    self.sent_requests.where(requested_id: other_user.id)
  end

  def received_request_from(other_user)
    self.received_requests.where(requestor_id: other_user.id)
  end

  def feed
    #current user can be swapped for self
    requested_friend_ids = Friendship.accepted.where(requestor_id: self.id).pluck(:requested_id)
    received_friend_ids  = Friendship.accepted.where(requested_id: self.id).pluck(:requestor_id)
    
    friend_ids = requested_friend_ids + received_friend_ids

    #WHERE   some_id = ANY(ARRAY[1, 2])
    Post.where("user_id = ANY(ARRAY#{friend_ids}::integer[]) OR user_id = :user_id", user_id: self.id).order(created_at: :desc)
  end

  #facebook omniauth specific method, used in reg_controller
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #i may use this image later
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def send_welcome_mail
    UserMailer.welcome_mail(self).deliver_now
  end

  
end
