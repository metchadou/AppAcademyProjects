class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node = nil)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    @parent.children << self unless @parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if !children.include?(child_node)
      raise "Not a child of this node"
    else
      child_node.parent = nil
      self.children.delete(child_node)
    end
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    
    nil
  end
  
end