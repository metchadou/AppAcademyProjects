def duos(str)
  count = 0
  (0...str.length-1).each { |i| count += 1 if str[i] == str[i+1] }
  count
end

def sentence_swap(sentence, hash)
  words = sentence.split
  new_sentence = words.map do |word|
    if hash.has_key?(word)
      replacer = hash[word]
      replacer
    else
      word
    end
  end

  new_sentence.join(' ')
end

def hash_mapped(hash, proc, &block)
  new_hash = {}
  hash.each do |k, v|
    new_key = block.call(k)
    new_val = proc.call(v)
    new_hash[new_key] = new_val
  end
  new_hash
end

def counted_characters(str)
  arr = []
  str.each_char do |specimen|
    count = 0
    str.each_char do |ch|
      count += 1 if specimen == ch
    end
    arr << specimen if count > 2
  end
  arr.uniq
end

def triplet_true(str)
  (0...str.length-2).each do |i|
    return true if str[i] == str[i+1] && str[i] == str[i+2]
  end
  false
end

def energetic_encoding(str, chars)
  new_sentence = ""
  (0...str.length).each do |i|
    if chars.has_key?(str[i])
      new_sentence += chars[str[i]]
    elsif str[i] == " "
       new_sentence += str[i]
    else
      new_sentence += "?"
    end
  end
  new_sentence
end

def uncompress(str)
  uncompressed = ""
  while str.length > 0
    char = str[0]
    occurence = str[1]

    uncompressed += char * occurence.to_i
    2.times { str[0] = "" }
  end
  uncompressed
end

def conjunct_select(arr, *procs)
  arr.select { |el| procs.all? { |proc| proc.call(el) } }
end

def convert_pig_latin(sentence)
  words = sentence.split
  vowels = "aeiou"

  translation = (0...words.length).map do |i|
    if words[i].length < 3
      words[i]
    else
      if vowels.include?(words[i][0].downcase)
        words[i] += "yay"
      else
        words[i] = start_with_vowel(words[i])
        words[i] += "ay"
      end
    end
  end

  translation.join(" ")
end

def start_with_vowel(word)
  new_word = ""
  vowels = "aeiou"
  (0...word.length).each do |i|
    if vowels.include?(word[i])
      new_word += word[i..-1] + word[0..i-1]
      break
    end
  end
  
  return new_word.capitalize if word == word.capitalize
  new_word
end

def reverberate(sentence)
  words = sentence.split
  reverberated = words.map do |word|
    if word.length < 3
      word
    else
      convert_word(word)
    end
  end
  reverberated.join(" ")
end

def convert_word(word)
  vowels = "aeiouAEIOU"

  if vowels.include?(word[-1])
    new_word = word * 2
  else
    i = word.length - 1
    while i >= 0
      if vowels.include?(word[i])
        new_word = word + word[i..-1]
        break
      end
      i -= 1
    end
  end
  return new_word.capitalize if word == word.capitalize
  new_word
end

def disjunct_select(arr, *procs)
  arr.select { |el| procs.any? { |proc| proc.call(el) } }
end

def alternating_vowel(sentence)
  vowels = "aeiouAEIOU"
  words = sentence.split
  new_words = (0...words.length).map do |i|
    if i.even?
      (0...words[i].length).each do |j|
        if vowels.include?(words[i][j])
          words[i][j] = ""
          break
        end
      end
      words[i]
    else
      j = words[i].length - 1
      while j >= 0
        if vowels.include?(words[i][j])
          words[i][j] = ""
          break
        end
        j -= 1
      end
      words[i]
    end
  end
  new_words.join(" ")
end

def silly_talk(sentence)
  words = sentence.split

  new_words = words.map do |word|
    translate_word(word)
  end

  new_words.join(" ")
end

def translate_word(word)
  translated_word = ""
  vowels = "aeiouAEIOU"

  if vowels.include?(word[-1])
    translated_word += word + word[-1]
  else
    word.each_char do |ch|
      if vowels.include?(ch)
        translated_word += ch + "b" + ch
      else
        translated_word += ch
      end
    end
  end

  return translated_word.capitalize if word == word.capitalize
  translated_word
end

def compress(str)
  compressed = ""
  i = 0
  while i < str.length
    ch = str[i]
    count = 0
    while str[i] == ch
      count += 1
      i += 1
    end
    count > 1 ? compressed += ch + count.to_s : compressed += ch
  end

  compressed
end

p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"