require 'rspec'
require 'card'

describe 'Card' do

  describe '#initialize' do

    subject(:card) { Card.new(:king, :hearts) }

    it 'only accepts valid value-suit pairs' do
      expect do
        bad_card = Card.new(:hearts, :king)
      end.to raise_error("Invalid card!")
    end

    it 'has a readable value' do
      expect(card.value).to eq(:king)
    end

    it 'has a readable suit' do
      expect(card.suit).to eq(:hearts)
    end

    it 'cannot change its attributes' do
      expect do
        card.value = :deuce
      end.to raise_error(NoMethodError)
      expect do
        card.suit = :spades
      end.to raise_error(NoMethodError)
    end


  end


end
