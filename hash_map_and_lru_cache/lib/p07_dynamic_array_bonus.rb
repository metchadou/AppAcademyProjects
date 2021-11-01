class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i >= length
      return nil
    elsif i < 0
      i = length + i
      return nil if i < 0
    end

    @store[i]
  end

  def []=(i, val)
    if i < 0
      i = length + i
      return nil if i < 0
    elsif i > length
      push(nil) until length > i
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each {|el| return true if el == val}

    false
  end

  def push(val) # nil
    resize! if length == capacity # 2 == 3

    i = length # i == 2
    self[i] = val # self[2] = nil
    @count += 1

    self
  end

  def unshift(val)
    (0...length).reverse_each do |i|  
      self[i+1] = self[i]
      self[i] = val if i == 0
    end

    @count += 1

    resize! if length == capacity
  end

  def pop
    return nil if length == 0

    i = length - 1
    elt = self[i]
    self[i] = nil
    @count -= 1

    elt
  end

  def shift
    return nil if length == 0

    elt = self[0]

    (0...length).each do |i|
      if i == length - 1
        self[i] = nil
      else
        self[i] = self[i+1]
      end
    end

    @count -= 1

    elt
  end

  def first
    return nil if length == 0

    self[0]
  end

  def last
    return nil if length == 0

    self[length-1]
  end

  def each
    length.times {|i| yield self[i]}
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.count

    length.times {|i| return false unless self[i] == other[i]}
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)

    (0...capacity).each {|i| new_store[i] = self[i]}

    @store = new_store
  end
end
