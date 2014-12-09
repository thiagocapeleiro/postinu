class PostsController < ApplicationController
	http_basic_authenticate_with name: "john", password: "secret", except: [:index, :show]

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
		if params[:items]
			per_page = params[:items]
		else
			per_page = 25
		end
		@fetch_posts = Post.order('created_at ASC').page(params[:page]).per(per_page)
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end

	end
	
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:title,:text)
	end

end
