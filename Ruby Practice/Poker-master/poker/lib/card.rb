class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

    CARD_VALUES = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    CARD_VALUES.keys
  end

  attr_reader :value, :suit

  def initialize(value, suit)
    raise "Invalid card!" unless Card.valid_card?(value, suit)
    @value, @suit = value, suit
  end

  def self.valid_card?(value, suit)
    VALUE_STRINGS.has_key?(value) && SUIT_STRINGS.has_key?(suit)
  end

  def ==(other_card)
    self.value == other_card.value && self.suit == other_card.suit
  end

  def <=>(other_card)
    CARD_VALUES[@value] <=> CARD_VALUES[other_card.value]
  end

  def value_int
    CARD_VALUES[@value]
  end

end
