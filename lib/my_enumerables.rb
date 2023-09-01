module Enumerable
  # Your code goes here
  def my_all?
    my_each { |element| return false if yield(element) == false }
    true
  end

  def my_any?
    my_each { |element| return true if yield(element) }
    false
  end

  def my_count
    if block_given?
      count = 0
      my_each { |element| count += 1 if yield(element) }
      count
    else
      length
    end
  end

  def my_each_with_index
    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_inject(initial_value = 0)
    my_each { |element| initial_value = yield(initial_value, element) }
    initial_value
  end

  def my_map
    new_array = []
    my_each { |element| new_array.push(yield(element)) }
    new_array
  end

  def my_none?
    my_each { |element| return false if yield(element) }
    true
  end

  def my_select
    selected_items = []
    my_each { |element| selected_items.push(element) if yield(element) }
    selected_items
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
