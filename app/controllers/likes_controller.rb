class LikesController < ApplicationController
	before_action :load_post

	def create
		@like = current_user.likes.build
		@like.post = @post
		@like.save
		redirect_back fallback_location: root_path
	end

	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_back fallback_location: root_path
	end

	private
		def load_post
			@post = Post.find(params[:post_id])
		end
end
