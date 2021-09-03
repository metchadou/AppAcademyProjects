def element_count(arr)
  count = Hash.new(0)
  arr.each { |el| count[el] += 1 }
  count
end

def char_replace!(str, hash)
  str.each_char.with_index do |ch, i|
    str[i] = hash[ch] if hash.has_key?(ch)
  end
  str
end

def product_inject(nums)
  nums.inject { |acc, num| acc * num }
end