def hipsterfy(word)
  vowels = "aeiou"
  i = word.length - 1
  while i >= 0
    if vowels.include?(word[i])
      word[i] = ""
      return word
    end
    i -= 1
  end
  word
end

def vowel_counts(words)
  vowels = "aeiou"
  count = Hash.new(0)
  words.downcase.each_char do |char|
    count[char] += 1 if vowels.include?(char)
  end
  count
end

def caesar_cipher(message, n)
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  new_message = ""
    message.each_char do |char|
      if alphabet.include?(char)
        new_idx = alphabet.index(char) + n
        new_char = alphabet[new_idx % 26]
        new_message += new_char
      else
        new_message += char
      end
    end
  new_message
end