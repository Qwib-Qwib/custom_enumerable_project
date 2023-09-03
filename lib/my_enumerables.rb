module Enumerable
  # Your code goes here
  def my_all?
    # The splat operator makes it so that the  block can be given a variable amount of arguments, making it work for
    # both arrays and hashes without further coding required.
    my_each { |*collection_item| return false if yield(*collection_item) == false }
    true
  end

  def my_any?
    my_each { |*collection_item| return true if yield(*collection_item) }
    false
  end

  def my_count
    if block_given?
      count = 0
      my_each { |*collection_item| count += 1 if yield(*collection_item) }
      count
    else
      length
    end
  end

  def my_each_with_index
    index = 0
    # The splat operator wraps the item into an array, which is desirable when iterating over a hash to imitate the
    # hash behavior of each_with_index, but not when iterating over an array since we want to access each item directly
    # in that case.
    # To prevent issues, each item is converted into its content if its length is 1 (i.e. if it's a single object taken
    # from an array, as opposed to a key-value pair taken from a hash. No super satisfied with that answer, I'm not sure
    # it's all that extensible.
    my_each do |*collection_item|
      collection_item = collection_item[0] if collection_item.length == 1
      yield(collection_item, index)
      index += 1
    end
    self
  end

  def my_inject(initial_value = 0)
    my_each { |*collection_item| initial_value = yield(initial_value, *collection_item) }
    initial_value
  end

  def my_map
    new_array = []
    my_each { |*collection_item| new_array.push(yield(*collection_item)) }
    new_array
  end

  def my_none?
    my_each { |*collection_item| return false if yield(*collection_item) }
    true
  end

  def my_select
    selected_items = []
    my_each { |*collection_item| selected_items.push(*collection_item) if yield(*collection_item) }
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
      block.call(item)
    end
    self
  end
end

class Hash
  def my_each(&block)
    for key, value in self do
      block.call(key, value)
    end
    self
  end
end
