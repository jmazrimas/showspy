require 'rails_helper'
include SpotifyData

RSpec.describe SpotifyData, type: :controller do
  let(:current_user) { User.new(uid: '123', access_token: '123', refresh_token: '123') }

  it "can pull basic data" do
    expect(new_releases.length).to be > 1
  end
end