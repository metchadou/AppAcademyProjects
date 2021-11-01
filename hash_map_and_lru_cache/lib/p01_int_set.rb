# require "byebug"
class MaxIntSet

  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true unless @store[num] #...is already true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false if @store[num] #...is true (or exists)
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if self.include?(num)

    self[num] << num

    true
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket_index = num % num_buckets
    @store[bucket_index]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if self.include?(num)
    resize! if @count == num_buckets

    self[num] << num
    
    @count += 1

    true
  end

  def remove(num)
    removed = self[num].delete(num)
    @count -= 1 if removed
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket_index = num % num_buckets
    @store[bucket_index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    nums = @store.flatten

    nums.each {|num| remove(num)}

    new_buckets = Array.new(num_buckets) {Array.new}
    @store += new_buckets # old buckets + new buckets
    
    nums.each {|num| insert(num)}
  end
end
