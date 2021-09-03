def palindrome?(string)
  reverse = ""
  string.each_char { |char| reverse = char + reverse }

  string == reverse
end

def substrings(string)
  array = []
  i = 0
  while i < string.length
    j = i
    while j < string.length
      array << string[i..j]
      j += 1
    end
    i += 1
  end
  array 
end

def palindrome_substrings(string)
  substrings = substrings(string)
  palindrome_substrings = []

  substrings.each do |substring|
    if substring.length > 1 && palindrome?(substring) == true
      palindrome_substrings << substring
    end
  end

  palindrome_substrings
end