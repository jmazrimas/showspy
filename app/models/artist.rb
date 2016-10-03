class Artist < ApplicationRecord
  has_many :tracks
  serialize :genres
end
