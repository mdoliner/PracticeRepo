class Sub < ActiveRecord::Base

  validates :title, :moderator_id, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id)

  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs, source: :post
end
