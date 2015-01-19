class ShortenedUrl < ActiveRecord::Base

  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many :visitors, -> { distinct }, through: :visits, source: :visitor

  has_many :tag_topics, through: :taggings, source: :tag_topic

  def self.random_code
    begin
      code = SecureRandom.urlsafe_base64
      raise if ShortenedUrl.exists?(short_url: code)
    rescue
      retry
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def self.most_popular_by_tag(tag_topic)
    ShortenedUrl.joins(:tag_topics).joins(:visits).where('tag_topics.topic = ?', tag_topic).group('shortened_urls.id').order('COUNT(visits.*)').first
  end

  def num_clicks
    visits.size
  end

  def num_uniques
    visits.select(:visitor_id).count
  end

  def num_recent_uniques
    visits.select(:visitor_id).where({ created_at: (10.minutes.ago)..Time.now }).count
  end

end
