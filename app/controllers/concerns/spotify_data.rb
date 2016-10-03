module SpotifyData
  include APICalls

  def top_artists
    
    artists=[]
    spotify_artists = JSON.parse(api_call("https://api.spotify.com/","v1/me/top/artists"))

    spotify_artists['items'].each do |item|
      genre_list = item['genres'].to_a

      # p '!!!!!!!!!!!!!!!!'
      # p genre_list.class
      # p genre_list.to_s

      artists << Artist.find_or_create_by(name: item['name'], spotify_id: item['id'], genre_list: genre_list)
      # a << item['name']
    end

    artists

  end

  def build_user_top_artist_data

    tracks = []

    top_artists.each do |artist|
      tracks.concat(get_top_tracks(artist))
    end

    tracks_needing_profile = tracks.select { |track| !track.track_profile }

    tracks_needing_profile = tracks_needing_profile.map { |track| track.spotify_id }

    tracks_needing_profile.each_slice(100) do |track_set|
      get_track_attributes(track_set)
    end

  end

  def get_artist_id(artist_name)

    params = {
      q: artist_name,
      type: 'artist'
    }

    response  = JSON.parse(api_call("https://api.spotify.com/","v1/search",params))

    new_artist = Artist.find_or_create_by(name: artist_name, spotify_id: response['artists']['items'][0]['id'])

    new_artist.spotify_id

  end

  def get_related_artists(artist_code)

    params = {
      seed_artists: artist_code
    }
    JSON.parse(api_call("https://api.spotify.com/","v1/recommendations",params))

  end

  def get_top_tracks(artist)

    if !artist.tracks.exists?

      artist_code = artist.spotify_id

      params = {
        country: 'US'
      }

      raw_tracks = JSON.parse(api_call("https://api.spotify.com/","v1/artists/#{artist_code}/top-tracks",params))['tracks']

      artist = Artist.find_by(spotify_id: artist_code)
      tracks = []

      raw_tracks.each do |track|
        new_track = Track.find_or_create_by(artist: artist, spotify_id: track['id'])
        tracks << new_track if new_track
      end

      tracks
    else
      artist.tracks
    end

  end

  def get_track_attributes(track_ids)
    params = {
      ids: track_ids.join(',')
    }

    raw_attributes = JSON.parse(api_call("https://api.spotify.com/","v1/audio-features",params))['audio_features']

    track_ids.each_with_index do |track_id, i|
      track = Track.find_by(spotify_id: track_id)
      track_data = raw_attributes[i].keep_if { |k,v| TrackProfile.new.attributes.keys.include?(k) && k != 'id'}
      track.create_track_profile(track_data)
      # profile.track = Track.find_by(spotify_id: track_id)
      # profile.save
    end

  end


  def new_releases
    # this is only used for testing purposes
    api_call("https://api.spotify.com/","/v1/browse/new-releases")
  end

end