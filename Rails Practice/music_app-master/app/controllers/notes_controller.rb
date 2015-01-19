class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save!
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    if current_user == @note.user
      @note.destroy
      redirect_to track_url(@note.track_id)
    else
      render text: "403 FORBIDDEN"
  end

  private
  def note_params
    params.require(:note).permit(:content, :track_id)
  end
end
