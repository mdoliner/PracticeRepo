class PostsController < ApplicationController
  before_action :must_be_author, only: [:edit,:update]
  before_action :must_be_logged_in, only: [:new, :create]

  def new
    @post = Post.new
    @sub_ids = []
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_ids = params[:post][:sub_ids]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:notices] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sub_ids = @post.sub_ids
  end

  def update
    @post = Post.find(params[:id])
    @sub_ids = params[:post][:sub_ids] || []
    if !@sub_ids.empty? && @post.update(post_params)
      @post.sub_ids = @sub_ids
      redirect_to post_url(@post)
    else
      flash.now[:notices] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments_by_parent_id
  end

  def upvote
    @post = Post.find(params[:id])
    @post.votes.new(value: 1).save
    redirect_to post_url(@post)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.votes.new(value: -1).save
    redirect_to post_url(@post)
  end

  private

  def must_be_author
    post = Post.find(params[:id])
    redirect_to post_url(post) unless post.author == current_user
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
  end
end
