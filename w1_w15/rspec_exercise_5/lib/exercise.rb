def zip(*arrays)
  arr = []

  i = 0
  while i < arrays[0].length
    sub_arr = []
    arrays.each do |arr|
      sub_arr << arr[i]
    end
    arr << sub_arr
    i += 1
  end

  arr
end

def prizz_proc(arr, prc1, prc2)
  arr.select do |el|
    (prc1.call(el) || prc2.call(el)) && !(prc1.call(el) && prc2.call(el))
  end
end

def zany_zip(*arrays)
  arr = []

  longest_arr = arrays.map(&:length).max

  i = 0
  while i < longest_arr
    sub_arr = []
    arrays.each do |arr|
      if arr[i] == nil
        sub_arr << nil
      else
        sub_arr << arr[i]
      end
    end
    arr << sub_arr

    i += 1
  end
  
  arr
end

def maximum(arr, &prc)
  return nil if arr.empty?
  arr.inject do |max, el|
    if prc.call(el) >= prc.call(max)
      el
    else
      max
    end
  end
end

def my_group_by(arr, &prc)
  hash = Hash.new { |h, k| h[k] = [] }

  arr.each do |el|
    k = prc.call(el)
    hash[k] << el
  end

  hash
end

def max_tie_breaker(arr, proc, &prc)
  return nil if arr.empty?

  largest = nil
  largest_val = 0

  arr.each do |el|
    if prc.call(el) > largest_val
      largest = el
      largest_val = prc.call(el)
    elsif prc.call(el) == largest_val
      if proc.call(el) > largest_val
        largest = el
        largest_val = proc.call(el)
      end
    end
  end

  largest
end

def silly_syllables(sentence)
  vowels = "aeiou"
  words = sentence.split

  words.each_with_index do |word, i|
    if vowels_count(word) > 1
      words[i] = change_word(word)
    end
  end
  sentence = words.join(" ")
  
  sentence
end

def vowels_count(word)
  count = 0
  vowels = "aeiou"

  word.each_char { |ch| count += 1 if vowels.include?(ch) }

  count
end

def change_word(word)
  vowels = "aeiou"

  i = 0
  while i < word.length
    if vowels.include?(word[i])
      j = word.length - 1
      while j >= 0
        return word[i..j] if vowels.include?(word[j])
        j -= 1
      end
    end

    i += 1
  end

end