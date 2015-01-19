class Array

  def two_sum
    pairs = []

    self.each_with_index do |el1, i1|
      self.each_with_index do |el2, i2|
        next unless i2 > i1
        pairs << [i1, i2] if el1 + el2 == 0
      end
    end
    pairs
  end

end
