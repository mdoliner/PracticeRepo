class Post < ActiveRecord::Base

  validates :author_id, :title, presence: true
  validate :must_have_sub

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
  has_many :votes, as: :votable

  has_many :comments

  def comments_by_parent_id
    result = Hash.new { Array.new }
    self.comments.each do |comment|
      result[comment.parent_comment_id] += [comment]
    end

    result
  end

  private
  def must_have_sub
    errors[:subs] << "Must have at least one sub" if self.subs.empty?
  end

end
