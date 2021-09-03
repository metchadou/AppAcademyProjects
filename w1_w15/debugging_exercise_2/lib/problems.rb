# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"
def prime?(number)
  return false if number < 2

  (2...number).each do |num|
    return false if number % num == 0
  end

  true
end

def largest_prime_factor(number)
  divisor = number
  while divisor > 0
    return divisor if number % divisor == 0 && prime?(divisor) == true
    divisor -= 1
  end
end

def unique_chars?(string)
  counts = Hash.new(0)
  string.each_char { |char| counts[char] += 1 }
  counts.each { |k, v| return false if v > 1 }
  true
end

def dupe_indices(array)
  counts = Hash.new(0)
  indices = {}
  array.each { |ele| counts[ele] += 1 }
  counts.each do |k, v|
    temp = []
    if v > 1
      array.each_with_index do |ele, idx|
        if ele == k
          indices[ele] = temp.push(idx)
        end
      end
    end
  end

  indices
end

def ana_array(array1, array2)
  array1.each { |ele| return false if !array2.include?(ele) }
  array2.each { |ele| return false if !array1.include?(ele) }
  true
end