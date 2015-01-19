require_relative 'deck'

class Hand

  HAND_SIZE = 5

  attr_reader :cards, :deck

  def initialize(cards = [], deck)
    @cards, @deck = cards, deck
  end

  def count
    @cards.size
  end

  def draw(deck)
    @cards += deck.take(HAND_SIZE - count)
  end

  # def discard(*indices)
  #   if indices.any? { |index| index > (HAND_SIZE - 1) }
  #     raise "Cannot discards card indices greater than 4"
  #   end
  #   @cards = @cards.reject.with_index { |card, index| indices.include?(index) }
  # end

  def discard(*indices)
    if indices.any? { |index| index > (HAND_SIZE - 1) }
      raise "Cannot discards card indices greater than 4"
    end
    indices.sort!.reverse!
    indices.each do |index|
      deck.return_to_deck([@cards[index]])
      @cards.delete_at(index)
    end
    p @cards
  end

  protected

  def counts
    counts = Hash.new(0)
    @cards.each do |card|
      counts[card.value] += 1
    end
    counts
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    counts.any? { |card, count| count == 4 }
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    @cards.all? { |card| card.suit == @cards[0].suit }
  end

  def straight?
    prc = Proc.new { |card| card.value_int }
    (@cards.max.value_int - @cards.min.value_int == 4) && @cards.uniq.size == 5
  end

  def three_of_a_kind?
    counts.any? { |card, count| count == 3 }
  end

  def two_pair?
    counts.values.count(2) == 2
  end

  def pair?
    counts.any? { |card, count| count == 2 }
  end

end
