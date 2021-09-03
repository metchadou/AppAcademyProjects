# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    if self.length > 0 && self.all? { |num| num.is_a?(Integer) }
      return self.max - self.min
    elsif self.empty?
      return nil
    end
  end

  def average
    return nil if self.empty?
    self.sum / (self.length * 1.0)
  end

  def median
    return nil if self.empty?
    
    if self.length.odd?
      sorted_array = self.sort
      idx = sorted_array.length / 2
      median = sorted_array[idx]
      return median
    else self.length.even?
      sorted_array = self.sort
      idx1 = sorted_array.length / 2
      idx2 = idx1 - 1
      median = [sorted_array[idx1], sorted_array[idx2]].average
      return median
    end
  end

  def counts
    count = Hash.new(0)
    self.each { |ele| count[ele] += 1 }
    count
  end

  def my_count(value)
    count = 0
    self.each { |ele| count += 1 if ele == value }
    count
  end

  def my_index(value)
    self.each_with_index do |ele, idx|
      return idx if ele == value  
    end
    nil
  end

  def my_uniq
    already_seen = []
    new_array = []
    i = 0
    while  i < self.length
      if !already_seen.include?(self[i])
        already_seen << self[i]
        new_array << self[i]
      end
      i += 1
    end
    new_array
  end

  def my_transpose
    flattened = self.flatten
    i = 0
    while i < self.length
      j = 0
      while j < self.length
        self[j][i] = flattened.shift
        j += 1
      end
      i += 1
    end
    self
  end
end

