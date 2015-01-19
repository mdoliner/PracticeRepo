require 'rspec'
require 'hand'


describe 'Hand' do

  describe '#initialize' do


  end

  describe '#draw' do

    let(:starting_cards) do
      [
        double(:value => :three, :suit => :spades),
        double(:value => :deuce, :suit => :diamonds),
        double(:value => :king, :suit => :clubs)
      ]
    end

    let(:receiving_cards) do
      [
        double(:value => :six, :suit => :diamonds),
        double(:value => :seven, :suit => :diamonds)
      ]
    end

    let(:deck) { double("deck") }

    it 'adds enough cards to make a five card hand' do

      hand = Hand.new(starting_cards.dup, deck)
      expect(deck).to receive(:take).with(2).and_return(receiving_cards)
      hand.draw(deck)
      expect(hand.cards).to eq(starting_cards.concat(receiving_cards))
    end

  end

  describe '#discard' do

    subject(:hand) { Hand.new(cards.dup, deck) }

    let(:cards) do
      [
        double(:value => :three, :suit => :spades),
        double(:value => :deuce, :suit => :diamonds),
        double(:value => :king, :suit => :clubs),
        double(:value => :six, :suit => :diamonds),
        double(:value => :seven, :suit => :diamonds)
      ]
    end

    let(:deck) { double("deck", :return_to_deck => true) }


    it 'discards number of cards equal to specified indices' do
      hand.discard(1,3,4)
      expect(hand.count).to eq(2)
    end

    it 'discards cards at specified indices' do
      expect(deck).to receive(:return_to_deck).exactly(3).times
      hand.discard(1,3,4)
      expect(hand.cards).to eq([cards[0], cards[2]])
    end

    it 'will not accept card indices greater than 4' do
      expect { hand.discard(1,2,8) }.to raise_error("Cannot discards card indices greater than 4")
    end

  end

  describe '#beats?' do

    context 'one hand clearly beats other' do

      it 'ranks a straight flush better than four of a kind' do

      end

      it 'ranks four of a kind better than a full house' do

      end

      it 'ranks a full house better than a flush' do

      end

      it 'ranks a flush better than a straight' do

      end

      it 'ranks a straight better than three of a kind' do

      end

      it 'ranks three of a kind better than two pair' do

      end

      it 'ranks two pair better than one pair' do

      end

      it 'ranks two pair better than one pair' do

      end

      it 'no one likes you, high card.' do

      end

    end

    context 'same-ranked hands' do

      it 'properly compares two straights flush' do

      end

      it 'properly compares two fours of a kind' do

      end

      it 'properly compares two fulls house' do

      end

      it 'properly compares two flushes' do

      end

      it 'properly compares two straights' do

      end

      it 'properly compares two threes of a kind' do

      end

      it 'properly compares two twos pair' do

      end

      it 'properly compares two pairs (not two pair)' do

      end

      it 'properly compares two high cards' do

      end

    end

    context 'tie' do

      it 'recognizes a tie' do

      end

    end


  end

end
