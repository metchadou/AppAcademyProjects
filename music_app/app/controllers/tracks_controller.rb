class TracksController < ApplicationController
  before_action :require_login!

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end


  def create
    @track = Track.new(track_params)

    if @track.save
      flash[:success] = ["'#{@track.title}' added to tracks"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    render :edit
  end

  def update
    track = Track.find_by(id: params[:id])

    if track.update(track_params)
      redirect_to track_url(track)
    else
      flash[:errors] = track.errors.full_messages
      redirect_to edit_track_url(track)
    end
  end

  def destroy
    track = Track.find_by(id: params[:id])

    if track.destroy
      flash[:success] = ["track successfully deleted"]
      redirect_to album_url(track.album)
    else
      flash[:errors] = track.errors.full_messages
      redirect_to  album_url(track.album)
    end
  end

  private

  def track_params
    params.require(:track).permit(:title, :ord, :album_id, :lyrics, :category)
  end
end