class CommentsController < ApplicationController
	before_action :load_post

	def new
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.build(comment_params)
		@comment.post = @post
		@comment.save
		#debugger
		redirect_to root_url
	end

	private
		def comment_params
			params.require(:comment).permit(:body, :post)
		end

		def load_post
			@post = Post.find(params[:post_id])
		end
end
