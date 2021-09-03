require_relative "item.rb"

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    if Item.valid_date?(deadline)
      @items << Item.new(title, deadline, description)
      return true
    else
      return false
    end
  end

  def size
    @items.length
  end

  def valid_index?(index)
    index < @items.length && index >= 0
  end

  def swap(index_1, index_2)
    if self.valid_index?(index_1) && self.valid_index?(index_2)
      @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
      return true
    else
      return false
    end
  end

  def [](index)
    if self.valid_index?(index)
      return @items[index]
    else
      return nil
    end
  end

  def priority
    @items.first
  end

  def print
    label_len = self.label.length
    label = self.label
    p "-".ljust(50, "-")
    p " ".ljust(25-(label_len/2)) + "#{label}"
    p "-".ljust(50, "-")
    p "Index  |" + "  Item".ljust(25) + "|  Deadline"
    p "-".ljust(50, "-")
    @items.each_with_index do |item, idx|
      p "#{idx}".ljust(7) + "|" + "  #{item.title}".ljust(25) + "|  #{item.deadline}".ljust(11)
    end
    p "-".ljust(50, "-")
  end

  def print_full_item(index)
    @items.each_with_index do |item, idx|
      if self.valid_index?(index) && idx == index
        p "-".ljust(50, "-")
        p "#{item.title}".ljust(40) + "#{item.deadline}"
        p "#{item.description}"
        p "-".ljust(50, "-")
      end
    end
  end

  def print_priority
    priority_index = @items.index(self.priority)
    print_full_item(priority_index)
  end

  def up(index, amount = 1)
    if self.valid_index?(index)
      target_index = index - amount
      while index > target_index
        break if index == 0
        @items[index], @items[index-1] = @items[index-1], @items[index]
        index -= 1
      end
      return true
    else
      return false
    end
  end

  def down(index, amount = 1)
    if self.valid_index?(index)
      target_index = index + amount
      while index < target_index
        break if index == @items.index(@items.last)
        @items[index], @items[index+1] = @items[index+1], @items[index]
        index += 1
      end
      return true
    else
      return false
    end
  end

  def sort_by_date!
    @items.sort_by! {|item| item.deadline}  
  end
end