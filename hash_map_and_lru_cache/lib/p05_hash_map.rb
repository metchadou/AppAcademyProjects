require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
   bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets

    bucket = bucket(key)

    if bucket.include?(key)
      bucket.update(key, val)
    else
      bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    include?(key) ? bucket(key).get(key) : nil
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    k_v_pairs = self.map {|key, val| [key, val]}
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    k_v_pairs.each {|(key, val)| self[key] = val}
  end

  def bucket(key)
    bucket_index = key.hash % num_buckets

    @store[bucket_index] # returns linked list corresponding to index in @store
  end
end
