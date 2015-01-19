require_relative 'card'

class Deck

  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  attr_reader :cards

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!
  end

  def take(n)
    raise "Not enough cards." if n > count
    @cards.shift(n)
  end

  def return_to_deck(return_cards)
    @cards.concat(return_cards)
  end

end
