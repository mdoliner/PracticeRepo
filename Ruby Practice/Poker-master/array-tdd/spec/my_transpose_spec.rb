require 'rspec'
require 'my_transpose'

describe 'Array#my_transpose' do

  it 'transposes values in a square array' do
    test_arr = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]

    result_arr = [
      [1,4,7],
      [2,5,8],
      [3,6,9]
    ]

    expect(test_arr.my_transpose).to eq(result_arr)
  end

  it 'will not accept a non-square array' do
    bad_arr = [1,2,3]

    expect do
      bad_arr.my_transpose
    end.to raise_error("This is not a square array.")
  end


end
