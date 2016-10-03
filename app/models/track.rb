class Track < ApplicationRecord
  belongs_to :artist
  has_one :track_profile

end
