require 'rspec'
require 'remove_dups'

describe 'Array#my_uniq' do

  it 'returns an array' do
    expect([1,2,3].my_uniq.class).to be(Array)
  end

  it 'returns a duplicate-free array untouched' do
    expect([1,2,3,4,5].my_uniq).to eq([1,2,3,4,5])
  end

  it 'removes duplicates from an array' do
    test_arr = [1,3,5,3,4,3,5,2]
    (1..5).each do |num|
      expect(test_arr.my_uniq.count(num)).to eq(1)
    end
    # expect(test_arr.my_uniq.count(1)).to be(1)
    # expect(test_arr.my_uniq.count(2)).to be(1)
    # expect(test_arr.my_uniq.count(3)).to be(1)
    # expect(test_arr.my_uniq.count(4)).to be(1)
    # expect(test_arr.my_uniq.count(5)).to be(1)
  end

  it 'returns unique elements in order of their first appearance' do
    test_arr = [1,3,5,3,4,3,5,2]
    expect(test_arr.my_uniq).to eq([1,3,5,4,2])
  end

end
