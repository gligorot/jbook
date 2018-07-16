class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :notification_count

  def nil_friend_requests
 		Friendship.accepted_nil.where(requested: current_user)
 	end

 	def notification_count
  	#will have more things eventually? - oh you got a post comment/like, (comment like?)
  	#he accepted your friendship request// you are now freinds with *** ??
  	@notification_count = nil_friend_requests.count
  end
end
