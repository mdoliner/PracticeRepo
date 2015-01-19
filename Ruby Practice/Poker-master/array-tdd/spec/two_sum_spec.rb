require 'rspec'
require 'two_sum'

describe 'Array#two_sum' do

  it 'returns an empty array if given an empty array' do
    expect([].two_sum).to be_empty
  end

  it 'returns an empty array if no elements sum to zero' do
    expect([1,3,4,2].two_sum).to be_empty
  end

  it 'returns pairs of positions if elements sum to zero' do
    expect([1,-1,3,4,-3].two_sum).to include([0,1], [2,4])
  end

  it 'returns multiple pairs of positions if different indices with same number sum to zero' do
    expect([1,-1,-1].two_sum).to eq([[0,1], [0,2]])
  end

  it 'returns pairs in ascending order' do
    expect([1,-1,3,4,-3].two_sum).not_to eq([[2,4], [0,1]])
    expect([1,-1,3,4,-3].two_sum).to eq([[0,1], [2,4]])
  end

  it 'does not return trivial zero pairs' do
    expect([1,0,2].two_sum).not_to include([1,1])
  end

  it 'does not return the reversed version of an existing two_sum pair' do
    expect([1,-1,3,4,-3].two_sum).not_to include([1,0], [4,2])
  end

end
