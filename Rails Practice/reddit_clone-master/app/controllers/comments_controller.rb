class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:notices] = @comment.errors.full_messages
      @post = Post.find(params[:comment][:post_id])
      render :new
    end
  end

  def show
    @parent_comment = Comment.find(params[:id])
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.votes.new(value: 1).save
    redirect_to comment_url(@comment)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.votes.new(value: -1).save
    redirect_to comment_url(@comment)
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id,:parent_comment_id,:content)
  end
end
