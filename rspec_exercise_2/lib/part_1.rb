def partition(array, num)
  two_dim_array = Array.new(2) { Array.new(0) }
  
  array.each do |n|
    if n < num
      two_dim_array[0] << n
    else
      two_dim_array[1] << n
    end
  end

  two_dim_array
end

def merge(hash1, hash2)
  new_hash = {}
    hash1.each { |key, val| new_hash[key] = val }
    hash2.each { |key, val| new_hash[key] = val }
  new_hash
end

def censor(sentence, curse_words)
  vowels = "aeiou"
  new_sentence = []
  sentence.split(" ").each do |word|
    if curse_words.include?(word.downcase)
      word.each_char.with_index do |char, idx|
        if vowels.include?(char.downcase)
          word[idx] = "*"
        end
      end 
    end
    new_sentence << word
  end
  new_sentence.join(" ")
end

def power_of_two?(num)
  return true if num == 1
  i = num
  while i > 1
    quotient = i / 2.0
    i = quotient
  end
  quotient == 1
end