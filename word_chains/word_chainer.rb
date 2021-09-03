require "byebug"
require "set"

class WordChainer
  def initialize(dictionary_file)
    @dictionary = parse_dict_file(dictionary_file)
    @current_words = nil
    @all_seen_words = nil
  end
  
  def parse_dict_file(file)
    f = File.open(file)
    a = f.readlines
    a.map! do |w|
      w = w.split("")
      w.delete("\n")
      w.join("")
    end.to_set
  end

  def adjacent?(word_a, word_b) # do the two words differ by only one letter?
    return false if word_a.length != word_b.length

    (0...word_a.length).one? do |i|
      word_a[0...i] + word_a[i+1..-1] == 
      word_b[0...i] + word_b[i+1..-1]
    end
  end

  def adjacent_words(word)
    @dictionary.select {|dict_word| adjacent?(word, dict_word)}
  end

  def print_words(words)
    words.each do |word|
      puts "#{word} : #{@all_seen_words[word]}"
    end
  end

  def explore_current_words
    new_current_words = []

      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          unless @all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words[adjacent_word] = current_word
          end
        end
      end

      # print_words(new_current_words)
      # p"------------------------------------"
      
      @current_words = new_current_words
  end

  def build_path(target)
    return [] if target == nil

    path = []

    @all_seen_words.each do |adjacent_word, source|
      if adjacent_word == target
        path += [adjacent_word] + build_path(source)
      end
    end

    path
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty?
      explore_current_words
      break if @all_seen_words.include?(target)
    end

    puts build_path(target).reverse
  end

end
  

if __FILE__ == $PROGRAM_NAME
  WordChainer.new("dictionary.txt").run("duck", "ruby")
end