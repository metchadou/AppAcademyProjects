class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def self.random(length)
    pegs = Array.new(length, POSSIBLE_PEGS.keys.sample)
    return Code.new(pegs)
  end

  def self.from_string(pegs)
    code = Code.new(pegs.split(""))
    code
  end

  attr_reader :pegs

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map(&:upcase)
    else
      raise "Invalid Peg"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count_matches = 0
    guess.pegs.each_with_index do |char, idx|
      count_matches += 1 if char == self.pegs[idx]
    end
    count_matches
  end

  def num_near_matches(guess)
    code_dup = self.pegs.dup
    guess_dup = guess.pegs.dup

    guess_dup.each_with_index do |peg, idx|
      if peg == code_dup[idx]
        guess_dup[idx] = nil
        code_dup[idx] = nil
      end
    end

    guess_dup.delete(nil)
    code_dup.delete(nil)

    count = 0
    guess_dup.each_with_index do |peg, idx|
      if code_dup.include?(peg)
        count += 1
        code_dup.delete_at(code_dup.index(peg))
      end
    end

    count
  end

  def ==(code)
    code.pegs == self.pegs
  end

end