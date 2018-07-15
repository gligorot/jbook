class PostsController < ApplicationController

	before_action :correct_user, only: :destroy

	def index
		@post  = current_user.posts.build #post on top of feed
		#@posts = current_user.feed
		@posts = Post.all
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post sucessful!"
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	def destroy
		@post.destroy
		flash.now[:success] = "Post sucessfully deleted! /needs referrer thing"
		render root_url
	end

	private
		def post_params
			params.require(:post).permit(:body)
		end

		def correct_user
			@post = current_user.posts.find(params[:id])
			redirect_to root_url if @post.nil?
		end
end
