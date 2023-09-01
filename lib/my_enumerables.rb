module Enumerable
  # Your code goes here
  def my_all?
    # The splat operator makes it so that the  block can be given a variable amount of arguments, making it work for
    # both arrays and hashes without further coding required.
    my_each { |*elements| return false if yield(*elements) == false }
    true
  end

  def my_any?
    my_each { |*elements| return true if yield(*elements) }
    false
  end

  def my_count
    if block_given?
      count = 0
      my_each { |*elements| count += 1 if yield(*elements) }
      count
    else
      length
    end
  end

  def my_each_with_index
    index = 0
    my_each do |*elements|
      yield(*elements, index)
      index += 1
    end
    self
  end

  def my_inject(initial_value = 0)
    my_each { |*elements| initial_value = yield(initial_value, *elements) }
    initial_value
  end

  def my_map
    new_array = []
    my_each { |*elements| new_array.push(yield(*elements)) }
    new_array
  end

  def my_none?
    my_each { |*elements| return false if yield(*elements) }
    true
  end

  def my_select
    selected_items = []
    my_each { |*elements| selected_items.push(*elements) if yield(*elements) }
    selected_items
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each(&block)
    for item in self do
      # yield(item)
      block.call(item)
    end
    self
  end
end

class Hash
  def my_each(&block)
    for key, value in self do
      # yield(key, value)
      block.call(key, value)
    end
    self
  end
end
