class PostsController < ApplicationController
  before_action :require_post_author!, only: [:edit, :update]

  def upvote
    post = Post.find_by(id: params[:id])
    post.votes.create(value: 1)
    redirect_to post_url(post)
  end

  def downvote
    post = Post.find_by(id: params[:id])
    post.votes.create(value: -1)
    redirect_to post_url(post)
  end

  def show
    @post = Post.find_by(id: params[:id])
    
    # For comments without N+1 queries
    # @all_comments = @post.comments.includes(:author)

    # Faster comments
    @comments_by_parent_id = @post.comments_by_parent_id
    @top_level_comments_by_votes = @post.top_level_comments.sort_by do |cmnt|
      cmnt.total_upvotes
    end.reverse

    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_post_author!
    current_user.post_author?(params[:id].to_i)
  end
end
