require "byebug"
class Array
  def my_each(&block)
    element_index = 0
    array_length = self.length

    while element_index < array_length
      element = self[element_index]
      block.call(element)
      element_index += 1
    end

    self
  end

  def my_select(&block)
    selection = []
    self.my_each {|ele| selection << ele if block.call(ele) }

    selection
  end

  def my_reject(&block)
    selection = []
    self.my_each {|ele| selection << ele if block.call(ele) == false }

    selection
  end

  def my_any?(&block)
    self.my_each {|ele| return true if block.call(ele)}
    false
  end

  def my_all?(&block)
    self.my_each {|ele| return false if block.call(ele) == false}
    true
  end

  def my_flatten
    one_dimension_array = []

    #Go through each element of the array. If an element is an array, only take all elements inside it and add them to ONE_DIMENSIONAL_ARRAY. If an element is not an array, simply add it to ONE_DIMENSIONAL_ARRAY
    self.my_each do |ele|
      if ele.is_a?(Array)
        one_dimension_array += ele
      else
        one_dimension_array << ele
      end
    end

    # Check if ONE_DIMENSIONAL_ARRAY still contains an element that is an array
    if one_dimension_array.my_any? {|ele| ele.is_a?(Array)}
      one_dimension_array.my_flatten
    else
      return one_dimension_array
    end
  end

  def my_zip(*arrays)
    new_array = []

    (0...self.length).each do |i|
      subarray = []
      subarray << self[i]
      arrays.each do |arr|
        if arr[i] == nil
          subarray << nil
        else
          subarray << arr[i]
        end
      end
      new_array << subarray
    end

    new_array
  end

  def my_rotate(n = 1)
    if n >= 0 
      n.times do
        shifted = self.shift
        self << shifted
      end
    else
      n = -(n)
      n.times do
        popped = self.pop
        self.unshift(popped)
      end
    end
    
    self
  end

  def my_join(separator = "")
    joined = ""

    self.each_with_index do |ele, idx|
        joined += ele.to_s
        joined += separator unless idx == self.length - 1
    end

    joined
  end

  def my_reverse
    reversed = []

    i = self.length - 1
    while i >= 0
      reversed << self[i]
      i -= 1
    end

    reversed
  end

end