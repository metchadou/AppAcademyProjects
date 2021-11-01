class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return self.length.hash if self.empty?

    self.map.with_index do |el, i|
      el.hash + i.hash
    end.inject(:^)
  end
end

class String
  def hash
    chars = self.split("")
    chars_ordinals = chars.map {|char| char.ord}
    hash_code = chars_ordinals.hash

    hash_code
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted = self.sort_by {|_k, val| val}
    hash_code = sorted.hash

    hash_code
  end
end
