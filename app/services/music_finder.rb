class MusicFinder 
  def self.client
    Soundcloud.new({ 
      client_id: Rails.application.secrets.soundcloud_api_key,
      client_secret: Rails.application.secrets.soundcloud_secret
    })
  end

  def self.find_artist(name)
    artists = Artist.where("LOWER(full_name) LIKE '%#{name.downcase}%' OR LOWER(description) LIKE '%#{name.downcase}%'")

    if artists.any?
      artists
    else 
      # Recuperer les artistes via self.client.get... 
      # depuis l'API et les enregistrer dans la BDD
      users = client.get("/users", q: name)

      users.map do |user|
        Artist.create({
          full_name: user["username"],
          soundcloud_id: user["id"],
          description: user["description"],
          avatar_url: user["avatar_url"],
          permalink_url: user["permalink_url"],
          track_count: user["track_count"]
        })
      end
    end
  end

  def self.find_tracks(artist)
    if artist.tracks.any?
      artist.tracks 
    else
      tracks = client.get("/users/#{artist.soundcloud_id}/tracks")

      tracks.map do |track|
        artist.tracks.create({
          title: track["title"],
          stream_url: track["stream_url"],
          duration: track["duration"],
          artwork_url: track["artwork_url"],
        })
      end
    end
  end
end