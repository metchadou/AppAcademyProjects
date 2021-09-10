class Map
  def initialize
    @map = []
  end

  def set(key, value)
    @map.each do |pair|
      if pair[0] == key
        pair[-1] = value
        return pair
      end
    end

    @map << [key, value]
    [key, value]
  end

  def get(key)
    @map.each do |pair|
      if pair[0] == key
        return pair
      end
    end

    nil
  end

  def delete(key)
    @map.each do |pair|
      if pair[0] == key
        return @map.delete(pair)
      end
    end

    nil
  end

  def show
    p @map
  end
end