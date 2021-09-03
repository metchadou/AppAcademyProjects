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

  def my_print
    label_len = self.label.length
    label = self.label
    print "\n" + "-".ljust(55, "-")
    print "\n" + " ".ljust(25-(label_len/2)) + "#{label}"
    print "\n" + "-".ljust(55, "-")
    print "\n" +  "Index  |" + "  Item".ljust(25) + "|  Deadline".ljust(14) + "|  Done".ljust(7)
    print "\n" +  "-".ljust(55, "-")
    @items.each_with_index do |item, idx|
      print "\n" +  "#{idx}".ljust(7) + "|" + "  #{item.title}".ljust(25) + "|  #{item.deadline}".ljust(14) + "|  #{item.done ? '☑' : '☐' }".ljust(7)
    end
    print "\n" +  "-".ljust(55, "-")
  end

  def print_full_item(index)
    @items.each_with_index do |item, idx|
      if self.valid_index?(index) && idx == index
        print "-".ljust(50, "-")
        print "\n" +  "#{item.title}".ljust(30) + "#{item.deadline}".ljust(15) + "#{item.done ? '☑' : '☐' }"
        print "\n" + "#{item.description}"
        print "\n" + "-".ljust(50, "-")
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

  def toggle_item(index)
    @items[index].toggle
  end

  def remove_item(index)
    if valid_index?(index)
      @items.delete_at(index)
      return true
    else
      return false
    end
  end

  def purge
    @items.select! {|item| item.done == false}
  end
end