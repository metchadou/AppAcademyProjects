def select_even_nums(numbers)
  numbers.select(&:even?)
end

def reject_puppies(dogs)
  dogs.reject { |dog| dog["age"] <= 2}
end

def count_positive_subarrays(array)
  array.count { |arr| arr.sum > 0}
end

def aba_translate(word)
  vowels = "aeiou"
  chars = word.split("")
  new_chars = []
  chars.each do |char|
    if vowels.include?(char)
      new_chars << char + "b" + char
    else
      new_chars << char
    end
  end
  new_chars.join("")
end

def aba_array(words)
  words.map { |word| aba_translate(word) }
end