class ArtistsController < ApplicationController
  before_action :check_create_artists_permission, only: [:new]

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def check_create_artists_permission
    preference = Preference.first
    unless preference&.allow_create_artists
      redirect_to artists_path, alert: 'Creating new artists is not allowed.'
    end
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
