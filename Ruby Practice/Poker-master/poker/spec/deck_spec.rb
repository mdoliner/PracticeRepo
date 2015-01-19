require 'rspec'
require 'deck'

describe 'Deck' do

  describe '#initialize' do

    subject(:deck) { Deck.new }

    it 'creates a deck with 52 cards' do
      expect(deck.count).to eq(52)
    end

    it 'creates a deck with with no duplicate cards' do
      seen = []
      duplicates = false
      deck.cards.each do |card|
        duplicates = true if seen.include?(card)
        seen << card
      end
      expect(duplicates).to be_falsey
    end

  end

  describe '#shuffle' do

    it 'shuffles the deck in place' do
      deck1, deck2 = Deck.new, Deck.new
      deck2.shuffle
      expect(deck1.cards).not_to eq(deck2.cards)
    end

  end

  describe '#take' do

    let(:cards) do
      [
      Card.new(:four, :diamonds),
      Card.new(:three, :spades),
      Card.new(:jack, :hearts)
      ]
    end

    let(:deck) { Deck.new(cards.dup) }

    it 'returns n cards from the top of the deck' do
      expect(deck.take(2)).to eq(cards[0..1])
    end

    it 'removes n cards from the top of the deck' do
      deck.take(1)
      expect(deck.count).to eq(cards.size - 1)
    end

    it 'yells at you if you try to take more cards than are in the deck' do
      expect { deck.take(4) }.to raise_error("Not enough cards.")
    end

  end

  describe '#return_to_deck' do

    let(:returned_cards) do
      [
      Card.new(:four, :diamonds),
      Card.new(:three, :spades),
      Card.new(:jack, :hearts)
      ]
    end

    let(:deck) { Deck.new([Card.new(:queen, :diamonds)]) }

    before(:each) { deck.return_to_deck(returned_cards) }

    it 'adds card to the deck' do
      expect(deck.count).to eq(4)
    end

    it 'adds cards to bottom of the deck' do
      expect(deck.cards.drop(1)).to eq(returned_cards)
    end

  end



end
