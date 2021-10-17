class MyQueue
  
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @size.size
  end

  def empty?
    @store.empty?
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end
end