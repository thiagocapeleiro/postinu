class CommentsController < ApplicationController
	http_basic_authenticate_with name: "john", password: "secret", only: :destroy

	def create
		@post = Post.find(params[:post_id])
			@comment = @post.comments.create(comments_params)
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private
	def comments_params
		params.require(:comment).permit(:commenter,:body)
	end
end
