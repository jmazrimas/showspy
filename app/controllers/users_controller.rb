class UsersController < ApplicationController
include SpotifyData

  def spotify
    user = User.find_or_create_by(uid: uid)
    user.access_token = access_token
    user.refresh_token = refresh_token
    user.token_expires_at = expire_time

    if user.save
      session[:user_id]=user.id
      build_spotify_data
    else
      @errors = ["Unable to authenticate"]
    end

    render 'events/index'
  end

  def logout
    session[:user_id]=nil
    render 'events/index'
  end

  def build_spotify_data
    current_user.update(artists: build_user_top_artist_data)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def uid
    auth_hash.uid
  end

  def access_token
    auth_hash.credentials.token
  end

  def refresh_token
    auth_hash.credentials.refresh_token
  end

  def expire_time
    unix_time = auth_hash.credentials.expires_at.to_i
    Time.at(unix_time).to_datetime
  end

end