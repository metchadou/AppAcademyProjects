require 'byebug'
require_relative "min_max_stack"

class MinMaxStackQueue
  
  def initialize
    @front_store = MinMaxStack.new
    @back_store = MinMaxStack.new
  end

  def size
    @front_store.size == 0 ? @back_store.size : @front_store.size
  end

  def empty?
    @front_store.empty? && @back_store.empty?
  end

  def enqueue(el)
    until @front_store.empty?
      @back_store.push(@front_store.pop)
    end

    @back_store.push(el)
  end

  def dequeue
    # debugger
    until @back_store.empty?
      @front_store.push(@back_store.pop)
    end

    @front_store.pop
  end

  def max
    if @back_store.max && @front_store.max
      case @back_store.max <=> @front_store.max
      when 0, 1
        @back_store.max
      when -1
        @front_store.max
      end
    end
    
    @back_store.max || @front_store.max
  end

  def min
    if @back_store.min && @front_store.min
      case @back_store.min <=> @front_store.min
      when 0, -1
        @back_store.min
      when -1
        @front_store.min
      end
    end
    
    @back_store.min || @front_store.min
  end
end