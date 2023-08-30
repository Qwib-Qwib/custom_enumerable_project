module Enumerable
  # Your code goes here
  def my_all?
    for item in self do
      return false if yield(item) == false
    end
    true
  end

  def my_any?
    for item in self do
      return true if yield(item) == true
    end
    false
  end

  def my_count
    if block_given?
      count = 0
      for item in self do
        count += 1 if yield(item) == true
      end
      count
    else
      length
    end
  end

  def my_each_with_index
    index = 0
    for item in self do
      yield(item, index)
      index += 1
    end
    self
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for item in self do
      yield(item)
    end
    self
  end
end
