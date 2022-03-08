class CommentsController < ApplicationController
  
  def upvote
    comment = Comment.find_by(id: params[:id])
    comment.votes.create(value: 1)
    redirect_to comment_url(comment)
  end

  def downvote
    comment = Comment.find_by(id: params[:id])
    comment.votes.create(value: -1)
    redirect_to comment_url(comment)
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
