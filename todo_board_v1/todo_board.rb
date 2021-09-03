require_relative 'list.rb'

class TodoBoard
  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split

    case cmd
    when 'mktodo'
      @list.add_item(*args)
    when 'up'
      args.map!(&:to_i)
      @list.up(*args)
    when 'down'
      args.map!(&:to_i)
      @list.down(*args)
    when 'swap'
      args.map!(&:to_i)
      @list.swap(*args)
    when 'sort'
      @list.sort_by_date!
    when 'priority'
      @list.print_priority
    when 'print'
      if args == []
        @list.print
      else
        args.map!(&:to_i)
        @list.print_full_item(*args)
      end
    when 'quit'
      return false
    else
      print "Sorry, that command is not recognized"
    end

    true
  end

  def run
    interact_with_user = true
    while interact_with_user
      interact_with_user = self.get_command
    end
  end
end