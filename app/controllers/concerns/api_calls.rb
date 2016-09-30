module APICalls

  def api_call(url, endpoint, params=nil)

    uri = URI.parse("#{url}#{endpoint}")
    uri.query = URI.encode_www_form(params) if params
    http = Net::HTTP.new(uri.host, uri.port)
    if url.include?("https")
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request = Net::HTTP::Get.new(uri.request_uri)
    if url.include?("spotify")
      request['Authorization'] = "Bearer #{current_user.access_token}"
    end
    http.request(request).body
  end


end