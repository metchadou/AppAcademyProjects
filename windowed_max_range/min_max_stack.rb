require "byebug"
class MinMaxStack

  attr_reader :max, :min
  def initialize
    @store = []
    @store_values_indices = {}
    @max = nil
    @min = nil
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
  
  def pop
    el = @store.pop
    @store_values_indices[el] = nil

    if el == @max && el == @min
      @max, @min = nil, nil
    else
      @max -= 1 until @store_values_indices[@max]
      @min += 1 until @store_values_indices[@min]
    end

    el
  end

  def push(el)
    @max = el if @max.nil? || el > @max
    @min = el if @min.nil? || el < @min
    @store_values_indices[el] = true
    @store.push(el)
  end
end