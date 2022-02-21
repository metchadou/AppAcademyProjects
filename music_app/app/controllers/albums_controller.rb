class AlbumsController < ApplicationController
  before_action :require_login!

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:success] = ["'#{@album.title}' added to albums"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    album = Album.find_by(id: params[:id])

    if album.update(album_params)
      redirect_to album_url(album)
    else
      flash[:errors] = album.errors.full_messages
      redirect_to edit_album_url(album)
    end
  end

  def destroy
    album = Album.find_by(id: params[:id])

    if album.destroy
      flash[:success] = ["album successfully deleted"]
      redirect_to bands_url
    else
      flash[:errors] = album.errors.full_messages
      redirect_to bands_url
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :band_id, :category)
  end
end