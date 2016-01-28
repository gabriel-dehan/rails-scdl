require 'soundcloud-downloader'
require "open-uri"

class TracksController < ApplicationController
  def download
    track = Track.find(params[:id])
    downloader = SoundCloud::Downloader::Client.new(client_id: Rails.application.secrets.soundcloud_api_key)
    url = downloader.resolve(track.stream_url)

    # Makes the browser download the file
    send_data(open(url).read,
      :type => "audio/mpeg",
      :disposition => "attachment; filename=\"#{track.title}.mp3\"")
  end
end