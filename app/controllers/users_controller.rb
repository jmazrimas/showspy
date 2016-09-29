class UsersController < ApplicationController


  def spotify
    user = User.find_or_create_by(uid: uid)
    user.access_token = access_token
    user.refresh_token = refresh_token

    if user.save
      session[:user_id]=user.id
    else
      @errors = ["Unable to authenticate"]
    end

    render 'shows/index'
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

end