class Comment < ActiveRecord::Bass
  belongs_to :commentable, polymorphic: true
end
