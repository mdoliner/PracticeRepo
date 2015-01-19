class ContactsController < ApplicationController

  def index
    @contacts = Contact.where(params[:user_id])
    render json: @contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update!(contact_params)
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy!
    render json: @contact
  end

  def favorite
    @contact = Contact.find(params[:id])
    @contact.favorite ? @contact.favorite = false : @contact.favorite = true
    if @contact.save
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email)
  end

end
