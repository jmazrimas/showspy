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

  def new_releases
    # this is only used for testing purposes
    api_call("https://api.spotify.com/","/v1/browse/new-releases")
  end

end