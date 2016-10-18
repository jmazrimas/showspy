module SpotifyData
  include APICalls

  # can't test b/c it requires auth
  def top_artists
    
    artists=[]
    spotify_artists = JSON.parse(api_call("https://api.spotify.com/","v1/me/top/artists"))

    spotify_artists['items'].each do |item|
      new_artist = Artist.find_or_create_by(name: item['name'], spotify_id: item['id'])
      new_artist.update(genre_list: item['genres'])
      artists << new_artist
    end

    artists

  end

  def add_spotify_data_to_artist(artist)
    get_artist_info(artist.name)
  end

  def refresh_token
    refresh_spotify_token
  end

  # can't test b/c it requires auth
  def build_user_top_artist_data

    tracks = []

    user_top_artists = top_artists

    user_top_artists.each do |artist|
      tracks.concat(get_top_tracks(artist))
    end

    create_needed_profiles(tracks)

    user_top_artists

  end


  def create_needed_profiles(tracks)
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

  def get_artist_info(artist_name)

    params = {
      q: artist_name,
      type: 'artist'
    }

    response  = JSON.parse(api_call("https://api.spotify.com/","v1/search",params))


    if !response['error'] && response['artists']['items'].length > 0
      artist = enrich_artist(artist_name, response)
    else
      artist = nil
    end

    if !Rails.env.test? && artist
      tracks = get_top_tracks(artist)
      create_needed_profiles(tracks)
    end

    artist

  end

  def enrich_artist(artist_name, api_response)
    artist = Artist.find_or_create_by(name: artist_name)
    artist.spotify_id = api_response['artists']['items'][0]['id']
    artist.genre_list = api_response['artists']['items'][0]['genres']
    artist.save

    artist
  end

  # can't test b/c it requires auth
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

      response = api_call("https://api.spotify.com/","v1/artists/#{artist_code}/top-tracks",params)

      raw_tracks = JSON.parse(response)['tracks']

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

  # can't test b/c it requires auth
  def get_track_attributes(track_ids)
    params = {
      ids: track_ids.join(',')
    }

    raw_attributes = JSON.parse(api_call("https://api.spotify.com/","v1/audio-features",params))['audio_features']

    track_ids.each_with_index do |track_id, i|
      track = Track.find_by(spotify_id: track_id)
      track_data = raw_attributes[i].keep_if { |k,v| TrackProfile.new.attributes.keys.include?(k) && k != 'id'}
      track.create_track_profile(track_data)
    end

  end


  # this is only used for testing purposes
  def new_releases
    api_call("https://api.spotify.com/","/v1/browse/new-releases")
  end

end