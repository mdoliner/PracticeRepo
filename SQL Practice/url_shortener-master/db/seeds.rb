# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

topics = [
  "Music", "Movies", "Fashion", "News", "Viral Links",
  "Viral Infections", "Cooking", "Sports", "Kittens",
  "Buzzfeed List", "Technology", "NSFW", "Pastels",
  "Soothing Images", "Email Chains", "Potpourri"]

topics.each do |topic|
  TagTopic.create!(topic: topic)
end
