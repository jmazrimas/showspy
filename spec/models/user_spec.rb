require 'rails_helper'

RSpec.describe User, type: :model do
  let(:artist1) {Artist.new(name:"BluesBand", genre_list: ["blues", "rock", "hipster"])}
  let(:artist2) {Artist.new(name:"RapRock", genre_list: ["rock", "hip-hop"])}
  let(:user1) {
    u = User.new(uid: "xyz")
    u.artists << artist1
    u.artists << artist2
    u
  }

  it "can be created with uid, access_token and refresh_token" do
    uid = 'abc123'
    access_token = 'atok'
    refresh_token = 'rtok'

    user = User.find_or_create_by(uid: uid)
    user.access_token = access_token
    user.refresh_token = refresh_token

    expect(user.save).to eq(true)

  end

  it "has a genre profile" do
    expect(user1.listening_genre_profile).to eq({"blues"=>1, "hip-hop"=>1, "hipster"=>1, "rock"=>2})
  end

  it "is able to score track genres against it's own" do
    expect(user1.score_track_genres(["rock","country"])).to eq(40)
  end

  

end
