# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".


# mississippi
def compress_str(str)
  new_str = ""
  i = 0
  while i < str.length # 11 < 11
    if str[i] == str[i+1] # i == nil
      count = 1
      j = i # j == 8
      while str[j] == str[j+1] # p == i
        count += 1 # count = 2
        j += 1 # j = 9
      end
      new_str += count.to_s + str[i] # mi2si2si2p
      i = j+1 # i = 10
    elsif str[i+1] == nil # nil == nil
      new_str += str[i] # mi2si2si2pi
      i += 1
    else
      new_str += str[i] # mi2si2si
      i += 1 # i = 8
    end
  end
  new_str
end


p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"