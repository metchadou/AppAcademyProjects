class LRUCache

  def initialize(size = 2)
    @size = size
    @list = []
  end

  def count
    @list.count
  end

  def add(elt)
    remove_existing(elt)
    remove_lru if full?
    @list.push(elt)
  end

  def show
    p @list
  end

  private

  def remove_existing(elt)
    @list.delete(elt)
  end

  def full?
    @list.size == @size
  end

  def remove_lru
    @list.shift
  end

end