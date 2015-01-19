# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

json.title @board.title
json.user @board.user, :email

json.lists @board.lists do |list|
  json.title list.title
  json.ord list.ord
  json.id list.id
  json.board_id list.board_id
  json.cards list.cards do |card|
    json.title card.title
    json.description card.description
  end
end
