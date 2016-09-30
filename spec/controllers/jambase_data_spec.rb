require 'rails_helper'
include JambaseData

RSpec.describe JambaseData, type: :controller do
  let(:current_user) { User.new(uid: '123', access_token: '123', refresh_token: '123') }

  it "will return valid venue listings" do
    expect(get_venues('double door').length).to be > 1
  end

  it "will return nothing for an invalid search" do
    expect(get_venues('asdfasfdasdf').length).to eq 0
  end


end