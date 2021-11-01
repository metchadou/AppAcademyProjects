class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if self.include?(key)
    resize! if @count == num_buckets

    self[key] << key
    
    @count += 1

    true
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    removed = self[key].delete(key)
    @count -= 1 if removed
  end

  private

  def [](key)
    bucket_index = key.hash % num_buckets
    @store[bucket_index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    keys = @store.flatten

    keys.each {|key| remove(key)}

    new_buckets = Array.new(num_buckets) {Array.new}
    @store += new_buckets # old buckets + new buckets
    
    keys.each {|key| insert(key)}
  end
end
