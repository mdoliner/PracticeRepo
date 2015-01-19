class Track < ActiveRecord::Base
  TRACK_TYPES = %w(Regular Bonus)

  validates :name, :album_id, :track_type, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to :album
  has_many :notes

end
