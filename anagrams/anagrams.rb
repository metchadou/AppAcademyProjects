def first_anagram?(str1, str2)
  str1_chars = str1.split("")
  str2_chars = str2.split("")
  all_possible_anagrams_of_str1 = str1_chars.permutation(str1.length)
  
  all_possible_anagrams_of_str1.include?(str2_chars)
end

# puts first_anagram?("anacondahjudiaopmdjtchg", "adocannagfhtydujsnhdtru") # => false

def second_anagram?(str1, str2)
  str2_chars = str2.split("")

  str1.each_char do |char|
    idx = str2_chars.find_index(char)
    str2_chars.delete_at(idx) unless idx.nil?
  end

  str2_chars.empty?
end

def third_anagram?(str1, str2)
  str1.split("").sort == str2.split("").sort
end

def fourth_anagram?(str1, str2)
  str1_chars_count = Hash.new(0)
  str2_chars_count = Hash.new(0)

  str1.each_char {|char| str1_chars_count[char] += 1}
  str2.each_char {|char| str2_chars_count[char] += 1}

  str1_chars_count == str2_chars_count
end

def fifth_anagram?(str1, str2)
  str1_chars_count = Hash.new(0)

  str1.each_char {|char| str1_chars_count[char] += 1}

  str2.each_char do |char|
    if str1_chars_count[char].nil? || str1_chars_count[char] != str2.count(char)
      return false
    end
  end

  true
end

# puts second_anagram?("ai", "ia") # => true
# puts second_anagram?("bad", "cab") # => false
# puts second_anagram?("race", "acre") # => true
# puts second_anagram?("anhdtuancghtqujepmdjauacondahjudiaopmdjtchg", "anhdtuancghtqujepmdjauacondahjudiaopmdjtchg") # => true
# puts third_anagram?("anhdtuancghtqujepmdjauacondahjudiaopmdjtchg", "anhdtuancghtqujepmdjauacondahjudiaopmdjtchg") # => true
# puts fifth_anagram?("anhdtuancghtqujepmdjauacondahjudiaopmdjtchganhdtuancghtqujepmdjauacondahjudiaopmdjtchg", "anhdtuancghtqujepmdjauacondahjudiaopmdjtchganhdtuancghtqujepmdjauacondahjudiaopmdjtchg") # => true