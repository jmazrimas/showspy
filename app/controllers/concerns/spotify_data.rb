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

  def new_releases
    # this is only used for testing purposes
    api_call("https://api.spotify.com/","/v1/browse/new-releases")
  end

end