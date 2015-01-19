class Tagging < ActiveRecord::Base
  validates :tag_id, presence: true
  validates :url_id, presence: true

  belongs_to(
    :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_id,
    primary_key: :id
  )

  belongs_to(
    :tagged_url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
  )

  def self.create_for_url_and_topic!(url, topic)
    Tagging.create!(url_id: url.id, tag_id: TagTopic.find_by_topic(topic).id)
  end

end
