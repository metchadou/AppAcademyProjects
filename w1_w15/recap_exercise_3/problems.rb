def no_dupes?(array)
  count = Hash.new(0)

  array.each do |ele|
    count[ele] += 1
  end
  
  p count.keys.select { |ele| count[ele] == 1 } 
end

def no_consecutive_repeats?(arr)
  (0...arr.length-1).each do |i|
    return false if arr[i] == arr[i+1]
  end
  true
end

def char_indices(str)
  indices = Hash.new { |h, k| h[k] = [] }

  str.each_char.with_index do |char, idx|
    indices[char] << idx
  end

  indices
end

def longest_streak(str)
  longest_str = ""
  streaks = []

  i = 0
  while i < str.length
    streak = str[i]
      j = i+1
      while str[i] == str[j]
        streak += str[j]
        j += 1
      end

      streaks << streak
    i = j
  end

  streaks.each do |strk|
    if strk.length >= longest_str.length
      longest_str = strk
    end
  end

  longest_str
end

def bi_prime?(num)
  (2...num).each do |prime1|
    if prime?(prime1)
      (2...num).each do |prime2|
        if prime?(prime2)
          return true if prime1 * prime2 == num
        end
      end
    end
  end
  false
end

def prime?(num)
  return false if num < 2
  (2...num).each { |i| return false if num % i == 0 }
  true
end

def vigenere_cipher(message, keys)
  encrypted_message = ""

  while message.length > keys.length
    keys.each do |k|
      if message.length > keys.length
        keys << k
      end
    end
  end

  alphabet = ("a".."z").to_a

  message.each_char.with_index do |old_char, idx|
    (0...alphabet.length).each do |i|
      if old_char == alphabet[i]
        new_idx = (i + keys[idx]) % alphabet.length
        new_char = alphabet[new_idx]
        encrypted_message += new_char
      end
    end
  end

  p encrypted_message
end

def vowel_rotate(str)
  new_str = ""
  vowels = "aeiou"
  rotated = []

  str.each_char do |char|
    rotated << char if vowels.include?(char)
  end

  rotated.unshift(rotated.pop)

  (0...str.length).each do |i|
      if vowels.include?(str[i])
        str[i] = rotated.shift
        new_str += str[i]
      else
        new_str += str[i]
      end
  end

  new_str
end

class String

  def select(&prc)
    selected = ""
    return selected if prc == nil

    self.each_char do |ch|
      selected += ch if prc.call(ch) == true
    end

    p selected
  end

  def map! (&prc)
    self.each_char.with_index do |ch, i|
      self[i] = prc.call(ch, i)
    end
  end

end

def multiply(a, b)
  return 0 if a == 0 || b == 0
  
  if a < 0 && b < 0
    return multiply(a, b+1) + a.abs
  elsif a > 0 && b < 0
    return multiply(a, b+1) - a
  elsif a < 0 && b > 0
    return multiply(a, b-1) + a
  else
    return multiply(a, b-1) + a
  end
end

def lucas_sequence(num)
  return [2, 1] if num == 2
  return [2] if num == 1
  return [] if num == 0

  lucas_sequence(num - 1) + [lucas_sequence(num - 1)[-1] + lucas_sequence(num - 1)[-2]]
end

def prime_factorization(num)
  return [num] if prime?(num)

  i = smallest_prime_divisor(num)

  [i] + prime_factorization(num / i)
end

def prime?(num)
  return false if num < 2

  (2...num).each  {|f| return false if num % f == 0}
  true
end

def prime_factors(num) #12
  (2...num).select { |f| num % f == 0 && prime?(f)}
end

def smallest_prime_divisor(num)
  prime_factors(num).each do |n|
  return n if num % n == 0
  end
end