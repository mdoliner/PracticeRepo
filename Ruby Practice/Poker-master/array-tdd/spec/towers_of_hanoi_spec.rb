require 'rspec'
require 'towers_of_hanoi'

describe 'TowersOfHanoi' do

  describe '#initialize' do

    before(:each) do
      game = TowersOfHanoi.new
    end

    it 'creates a towers array with reader' do
      expect(game.towers).to be_an(Array)
    end

    it 'creates a 2-D towers array' do
      expect (game.towers).to all(be_an(Array))
    end

    it 'makes three towers' do
      expect(game.towers.size).to eq(3)
    end

    it 'creates a four-disc first tower when passed without parameters' do
      expect(game.towers.first.size).to eq(4)
    end

    it 'initializes last two towers as empty' do
      expect(game.towers[1]).to be_empty
      expect(game.towers[2]).to be_empty
    end

    it 'creates different-size towers when passed with parameters' do
      five_game = TowersOfHanoi.new(5)
      expect(five_game.towers.first.size).to eq(5)
      expect(five_game.towers[1]).to be_empty
      expect(five_game.towers[2]).to be_empty
    end

    it "initializes first tower with discs of unique, ascending sizes" do
      expect(game.towers.first).to eq([1,2,3,4])
    end

  end

  describe '#move' do

    subject(:game) { TowersOfHanoi.new }

    before(:each) do
      game.move(0,2)
    end

    it 'moves one disc from one tower' do
      expect(game.towers[0].size).to eq(3)
    end

    it 'places a disc on another tower' do
      expect(game.towers[2].size).to eq(1)
    end

    it 'will not move a disc from an empty tower' do
      expect do
        game.move(1,2)
      end.to raise_error("can't move disc from empty tower")
    end

    it "moves disc from beginning of from_arr" do
      expect(game.towers[0]).to eq([2,3,4])
    end

    before (:each) do
      game.move(0,1)
    end

    it 'moves disc to beginning of to_arr' do
      game.move(2,1)
      expect(game.towers[1]).to eq([1,2])
    end

    it 'will not place larger disc on top of smaller disc' do
      expect do
        game.move(0,2)
      end.to raise_error("can't move larger disc on top of smaller disc")
    end

  end

  describe '#over?' do

    subject(:game) { TowersOfHanoi.new }

    it 'returns true if all discs are on the third tower' do
      game.towers = [[],[],[1,2,3,4]]
      expect(game.over?).to be_true
    end

    it 'returns false if the first two towers aren\'t empty' do
      expect(game.over?).to be_false
    end

  end

  

end
