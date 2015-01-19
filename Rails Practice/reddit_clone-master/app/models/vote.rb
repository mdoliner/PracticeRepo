class Vote < ActiveRecord::Base
  VOTE_VALUES = [-1,1]

  validates :value, inclusion: VOTE_VALUES, presence: true
  validates :votable_id, :votable_type, presence: true

  belongs_to :votable, polymorphic: true

end
