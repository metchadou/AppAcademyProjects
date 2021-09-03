class HumanPlayer
  def prompt
    puts "Please enter the position of the card you'd like to flip (e.g., '2,3')"
  end

  def congrat
    puts "YOU WON !"
  end

  def get_input
    gets.chomp.split(",").map(&:to_i)
  end

  def receive_revealed_card(pos, val)
  end

  def receive_match(pos1, pos2)
  end

end