# require "byebug"
def my_uniq(ary)
  ary.each_with_object([]) do |el, uniqs|
    uniqs << el unless uniqs.include?(el)
  end
end

def two_sum(numbers)
  pairs = []

  numbers.each_with_index do |num1, i|
    numbers[i+1..-1].each_with_index do |num2, j|
      if num1 + num2 == 0
        idx_shift = numbers.length - numbers[i+1..-1].length
        pairs << [i, j + idx_shift]
      end
    end
  end

  pairs
end

def my_transpose(ary) # ary is assumed to be a square matrice
  new_array = Array.new(ary.length) { Array.new(ary.length)}

  (0...ary.length).each do |row|
    (0...ary.length).each do |col|
      new_array[row][col] = ary[col][row]
    end
  end

  new_array
end

def most_profitable_days_pair(prices)
  profit_per_days_pair = {}

  prices.each_with_index do |price_on_buy_day, buy_day|
    prices.each_with_index do |price_on_sell_day, sell_day|
      next if sell_day <= buy_day

      profit = price_on_sell_day - price_on_buy_day
      days_pair = [buy_day, sell_day]
      profit_per_days_pair[days_pair] = profit
    end
  end

  profit_per_days_pair.key(profit_per_days_pair.values.max) # returns pair with max profit
end

class Pile
  
  attr_reader :capacity, :stack
  def initialize(capacity)
    @stack = []
    @capacity = capacity
  end

  def add(element)
    @stack.push(element) unless full?
  end

  def remove
    @stack.pop unless empty?
  end

  def full?
    @stack.length == @capacity
  end

  def empty?
    @stack.empty?
  end

  def get
    @stack.last
  end

  def fill(array_of_elements)
    until full?
      @stack.push(array_of_elements.pop)
    end

    @stack
  end

  def available_space
    @capacity - @stack.length
  end

end

class TowerOfHanoi
  
  attr_reader :piles
  def initialize(max_disc_size)
    @piles = [
      Pile.new(max_disc_size),
      Pile.new(max_disc_size),
      Pile.new(max_disc_size)
    ]
    @size = max_disc_size

    place_discs_at_initial_pile
  end

  def play
    until won?
      begin
        render
        prompt
        input = get_input
        move(parse_input(input))
      rescue StandardError => e
        e.message
        retry
      end
    end
    
    congrat
  end

  def won?
    @piles.last.full?
  end

  def move(positions)
    positions.map! {|pos| pos-1}
    
    raise "Invalid position" if !valid_pos?(positions)

    source_pile = @piles[positions.first]
    target_pile = @piles[positions.last]
    
    unless target_pile.get.nil?
      raise "Move not allowed" if source_pile.get > target_pile.get
    end

    disc = source_pile.remove
    target_pile.add(disc)
  end

  def valid_pos?(positions)
    positions.all? {|pos| pos.between?(0, @size - 1)}
  end

  def get_input
    gets.chomp
  end

  def parse_input(input)
    input.split.map!(&:to_i)
  end

  def prompt
    puts "Select stacks to move the disks (e.g, '1 2' moves top disk from first stack to second stack)"
    print "> "
  end

  def render
    system('clear')
    pile1, pile2, pile3 = @piles[0].stack, @piles[1].stack, @piles[2].stack
    puts "#{pile1} #{pile2} #{pile3}"
  end

  def congrat
    render
    puts "Congratulations You win"
  end

  private

  def place_discs_at_initial_pile
    discs = (1..@size).to_a
    first_pile = @piles.first

    first_pile.fill(discs)
  end

end