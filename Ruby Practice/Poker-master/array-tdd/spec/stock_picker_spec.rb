require 'rspec'
require 'stock_picker'

describe '#stock_picker' do

  it "returns the most profitable days" do
    stocks = [4, 1, 5, 9]
    expect(stock_picker(stocks)).to eq([1,3])
  end

  it "does not return buy days that occur after sell days" do
    stocks = [100, 1, 5, 9]
    expect(stock_picker(stocks)).not_to eq([1,0])
  end

  it "returns an empty array if given an empty array" do
    expect(stock_picker([])).to be_empty
  end

end
