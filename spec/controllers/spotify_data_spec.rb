require 'rails_helper'
include SpotifyData

RSpec.describe SpotifyData, type: :controller do
  let(:current_user) { User.new(uid: '123', access_token: '123', refresh_token: '123') }
  let(:created_artist) { Artist.create(name: "The Darkness", spotify_id: "5r1bdqzhgRoHC3YcCV6N5a")}

  it "can pull basic data" do
    expect(new_releases.length).to be > 1
  end

  it "can pull spotify data for an existing artist" do
    expect(get_artist_info("The Darkness").spotify_id).to eq('5r1bdqzhgRoHC3YcCV6N5a')
  end

  it "can pull artist top tracks" do 
    expect(created_artist.tracks.count).to eq(0)
    get_top_tracks(created_artist)
    expect(created_artist.tracks.count).to be > 0
  end

end