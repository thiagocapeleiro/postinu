class PostsController < ApplicationController

	def new
		@post = Post.new
	end

	def create
		# render plain: params[:posts].inspect
		@post = Post.new(post_params)
		if @post.save

			redirect_to @post
		else
			render 'new'
		end
		
		#redirect_to	posts_path
	end

	def show
		@fetch_post = Post.find(params[:id])
	end

	def index
		@fetch_posts = Post.all
	end

	private
	def post_params
		params.require(:post).permit(:title,:text)
	end

end
