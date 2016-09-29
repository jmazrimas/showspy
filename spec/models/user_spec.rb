require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created with uid, access_token and refresh_token" do
    uid = 'abc123'
    access_token = 'atok'
    refresh_token = 'rtok'

    user = User.find_or_create_by(uid: uid)
    user.access_token = access_token
    user.refresh_token = refresh_token

    expect(user.save).to eq(true)

  end
end
