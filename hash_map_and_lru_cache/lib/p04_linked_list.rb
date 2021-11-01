class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next unless @prev.nil?
    @next.prev = @prev unless @next.nil?
  end

  def inspect
    {key: @key, val: @val}.inspect
  end

end

class LinkedList
  include Enumerable

  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end

    nil
  end

  def include?(key)
    return false if empty?

    each {|node| return true if node.key == key }

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    if empty?
      @head.next, @tail.prev = new_node, new_node
      new_node.next, new_node.prev = @tail, @head
    else
      new_node.next, new_node.prev = @tail, last
      last.next, @tail.prev = new_node, new_node
    end
  end

  def update(key, val)
    return false if empty?

    each do |node|
      if node.key == key
        node.val = val
        return true
      end
    end

    false
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        break
      end
    end
  end

  def each(&prc)
    return nil if empty?
    node = first

    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
