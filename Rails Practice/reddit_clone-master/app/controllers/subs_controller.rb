class SubsController < ApplicationController
  before_action :must_be_moderator, only: [:edit,:update]
  before_action :must_be_logged_in, only: [:new, :create]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:notices] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:notices] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private

  def must_be_moderator
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless sub.moderator == current_user
  end

  def sub_params
    params.require(:sub).permit(:title,:description,:moderator_id)
  end
end
