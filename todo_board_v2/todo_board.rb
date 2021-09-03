require_relative 'list.rb'

class TodoBoard
  def initialize
    @lists = {}
  end

  def get_command
    print "\nEnter a command: "
    cmd, *args = gets.chomp.split

    case cmd
    when 'mklist'
      @lists[*args] = List.new(*args)
    when 'ls'
      @lists.each_key {|label| puts label}
    when 'showall'
      @lists.each_value {|list| list.my_print}
    when 'mktodo'
      label = args[0]
      @lists[label].add_item(*args[1..-1])
    when 'up'
      label = args[0]
      @lists[label].up(*args[1..-1])
    when 'down'
      label = args[0]
      @lists[label].down(*args[1..-1])
    when 'swap'
      label = args[0]
      @lists[label].swap(*args[1..-1])
    when 'sort'
      @lists[*args].sort_by_date!
    when 'priority'
      @lists[*args].print_priority
    when 'my_print'
      if args.length == 1
        @lists[*args].my_print
      else
        label = args[0]
        @lists[label].print_full_item(args[1].to_i)
      end
    when 'toggle'
      label = args[0]
      @lists[label].toggle_item(args[1].to_i)
    when 'rm'
      label = args[0]
      @lists[label].remove_item(args[1].to_i)
    when 'purge'
      label = args[0]
      @lists[label].purge
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

my_board = TodoBoard.new

my_board.run