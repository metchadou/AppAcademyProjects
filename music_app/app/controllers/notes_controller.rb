class NotesController < ApplicationController
  before_action :require_login!

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    note = Note.find_by(id: params[:id])

    if !note.nil? && note.user_id == current_user.id
      note.destroy
      flash[:success] = ["note deleted"]
      redirect_to track_url(note.track_id)
    else
      render plain: "403 FORBIDDEN"
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :track_id)
  end
end