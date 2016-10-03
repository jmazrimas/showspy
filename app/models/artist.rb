class Artist < ApplicationRecord
  has_many :tracks
  serialize :genre_list
end
