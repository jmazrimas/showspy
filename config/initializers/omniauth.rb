require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_key"], ENV["spotify_secret"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end