module SpotifyData
  include APICalls

  def top_artists
    
    a=[]
    artists = JSON.parse(api_call("https://api.spotify.com/","v1/me/top/artists"))

    artists['items'].each do |item|
      a << item['name']
    end

    a

  end

  def get_artist_id(artist_name)

    params = {
      q: artist_name,
      type: 'artist'
    }

    response  = JSON.parse(api_call("https://api.spotify.com/","v1/search",params))
    response['artists']['items'][0]['id']

  end

  def get_related_artists(artist_code)

    params = {
      seed_artists: artist_code
    }
    JSON.parse(api_call("https://api.spotify.com/","v1/recommendations",params))

  end

  def get_top_tracks(artist_code)

    params = {
      country: 'US'
    }

    raw_tracks = JSON.parse(api_call("https://api.spotify.com/","v1/artists/#{artist_code}/top-tracks",params))['tracks']

    raw_tracks.collect do |track|
      track['id']
    end

  end

  def get_track_attributes(track_ids)
    params = {
      ids: track_ids.join(',')
    }

    raw_attributes = JSON.parse(api_call("https://api.spotify.com/","v1/audio-features",params))['audio_features']

    tracks_attributes = {}

    track_ids.each_with_index do |track_id, i|
      tracks_attributes[track_id] = raw_attributes[i]
    end

    tracks_attributes

  end

  # "danceability"=>0.314, "energy"=>0.844, "loudness"=>-6.797, "mode"=>0, "speechiness"=>0.0652, "acousticness"=>1.59e-05, "instrumentalness"=>0.00163, "liveness"=>0.35, "valence"=>0.127, "tempo"=>75.513, 

  def new_releases
    # this is only used for testing purposes
    api_call("https://api.spotify.com/","/v1/browse/new-releases")
  end

end