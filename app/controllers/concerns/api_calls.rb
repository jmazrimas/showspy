module APICalls
  require 'base64'
  require 'json'

  def api_call(url, endpoint, params=nil)

    uri = URI.parse("#{url}#{endpoint}")
    uri.query = URI.encode_www_form(params) if params
    http = Net::HTTP.new(uri.host, uri.port)
    if url.include?("https")
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request = Net::HTTP::Get.new(uri.request_uri)
    if url.include?("spotify") && !Rails.env.test?
      request['Authorization'] = "Bearer #{current_user.access_token}"
    end

    http.request(request).body
  end


  def refresh_spotify_token

    request_body = {
        grant_type: 'refresh_token',
        refresh_token: current_user.refresh_token
      }

    response = RestClient.post("https://accounts.spotify.com/api/token", request_body, RSpotify.send(:auth_header))
    parsed_response = JSON.parse(response)

    expire_time = Time.now.utc.to_i + parsed_response['expires_in']

    current_user.update(access_token: parsed_response['access_token'])
    current_user.update(token_expires_at: Time.at(expire_time).to_datetime)

  end


end