require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist1) {Artist.create(name:"BluesBand", genre_list: ["blues", "rock", "hipster"])}
  let(:artist2) {Artist.create(name:"RapRock", genre_list: ["rock", "hip-hop"])}

  let(:track1) {
    tp1 = TrackProfile.create(danceability: 0.445, energy: 0.119, loudness: -16.603, mode: 0.0, speechiness: 0.0311, acousticness: 0.958, instrumentalness: 4.51e-06, liveness: 0.104, valence: 0.166, tempo: 85.989)
    t1 = Track.create(artist: artist1, track_profile: tp1)
    t1.track_profile = tp1
    t1
  }

  let(:track2) {
    tp2 = TrackProfile.create(danceability: 0.588, energy: 0.751, loudness: -7.588, mode: 1.0, speechiness: 0.0328, acousticness: 0.00174, instrumentalness: 6.57e-05, liveness: 0.353, valence: 0.524, tempo: 136.979)
    t2 = Track.create(artist: artist1, track_profile: tp2)
    t2.track_profile = tp2
    t2
  }

  it "has a profile if it has tracks" do
    artist1.tracks << track1
    artist1.tracks << track2
    expect(artist1.average_track_profile).to eq([{"danceability"=>0.5165, "energy"=>0.435, "loudness"=>-12.0955, "speechiness"=>0.03195, "acousticness"=>0.47987, "instrumentalness"=>3.5105e-05, "liveness"=>0.2285, "valence"=>0.345, "tempo"=>111.484}])
  end
  
  it "has no profile if it has no tracks" do
    expect(artist2.average_track_profile).to eq([])
  end

end
