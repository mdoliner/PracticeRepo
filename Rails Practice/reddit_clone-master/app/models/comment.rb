class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to(:post)

  belongs_to(
  :author,
  class_name: "User",
  foreign_key: :author_id)

  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  has_many(
    :children_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  has_many :votes, as: :votable

end
