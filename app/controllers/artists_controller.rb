class ArtistsController < ApplicationController
  def search
  end

  def show
    @artist = Artist.find(params[:id])
    @tracks = MusicFinder.find_tracks(@artist)
  end

  def index
  	if params[:artist_name]
  		@artists = MusicFinder.find_artist(params[:artist_name])
   	else
   		@artists = Artist.all
   	end

    # On ne garde que les artistes qui ont des tracks
    @artists.to_a.select! { |artist| artist.track_count > 0 }
  end
end
