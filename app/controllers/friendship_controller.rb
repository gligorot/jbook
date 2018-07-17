class FriendshipController < ApplicationController
	before_action :load_user, only: :create
	before_action :make_variable, only: [:accept, :decline]

	def create
		current_user.sent_requests.create(requested: @user)
		flash[:notice] ="Friend request sent!"
		redirect_to profiles_path
	end

	#dry these two up later
	def accept
		@friendship = Friendship.find(params[:id])
		@friendship.update_attribute(:accepted, true)

		flash[:notice] = "You are now friends with #{@profile.name} #{@profile.surname}"
		redirect_back fallback_location: root_path
	end

	def decline
		@friendship = Friendship.find(params[:id])
		@friendship.update_attribute(:accepted, false)

		flash[:notice] = "You have declined the request of #{@profile.name} #{@profile.surname}"
		redirect_back fallback_location: root_path
	end

	private
		def make_variable
			@profile = @friendship.requestor.profile
		end

		def load_user
			@user = User.find(params[:user_id])
		end
end
