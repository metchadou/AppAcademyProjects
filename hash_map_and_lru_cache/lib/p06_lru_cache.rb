require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
    else
      calc!(key)
      eject! if count > @max
    end

    @store.last.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    @store.append(key, value)
    @map[key] = @store.last
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    unless node == @store.last
      @store.remove(node.key)
      @store.append(node.key, node.val)
      @map[node.key] = @store.last
    end
  end

  def eject!
    lru_key = @store.first.key
    @store.remove(lru_key)
    @map.delete(lru_key)
  end
end
