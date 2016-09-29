module SpotifyData

  def top_artists
    
    a=[]

    artists = JSON.parse(api_call("v1/me/top/artists"))

    artists['items'].each do |item|
      a << item['name']
    end

    a

  end


  def api_call(endpoint)
    uri = URI.parse("https://api.spotify.com/#{endpoint}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Authorization'] = "Bearer #{current_user.access_token}"
    http.request(request).body
  end

end