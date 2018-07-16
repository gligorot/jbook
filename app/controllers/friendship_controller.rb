class FriendshipController < ApplicationController
	#dry these two up later
	def accept
		@friendship = Friendship.find(params[:id])
		@friendship.update_attribute(:accepted, true)

		flash[:notice] = "You are now friends with #{@friendship.requestor.email}"
		redirect_back fallback_location: root_path
	end

	def decline
		@friendship = Friendship.find(params[:id])
		@friendship.update_attribute(:accepted, false)

		flash[:notice] = "You have declined the request of #{@friendship.requestor.email}"
		redirect_back fallback_location: root_path
	end
end
