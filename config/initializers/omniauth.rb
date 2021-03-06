require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_key"], ENV["spotify_secret"], scope: 'user-top-read user-library-read playlist-read-private user-read-private user-read-email'
end