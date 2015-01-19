class Album < ActiveRecord::Base

  ALBUM_TYPES = %w(Studio Live)

  validates :name, :band_id, :album_type, presence: true
  validates :album_type, inclusion: ALBUM_TYPES

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
