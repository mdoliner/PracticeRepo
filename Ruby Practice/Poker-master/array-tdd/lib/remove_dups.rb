class Array

  def my_uniq
    uniqs = []
    each { |el| uniqs << el unless uniqs.include?(el) }
    uniqs
  end

end
