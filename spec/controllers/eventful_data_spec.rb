require 'rails_helper'
include EventfulData

RSpec.describe EventfulData, type: :controller do
  let(:current_user) { User.new(uid: '123', access_token: '123', refresh_token: '123') }

  it "will return valid venue listings" do
    expect(get_venues('chicago','double door').length).to be > 1
  end

  it "will return nothing for an invalid search" do
    expect(get_venues('','asdfasfdasdf')).to eq nil
  end

  it "will return venues without a location" do
    expect(get_venues('','empty bottle').length).to be > 1
  end

end