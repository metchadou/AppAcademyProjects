# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num_1, num_2)
  common_divisors = []
  num_1_divisors = (1..num_1).select do |num|
    num_1 % num == 0
  end

  num_2_divisors = (1..num_2).select do |num|
    num_2 % num == 0
  end

  num_1_divisors.each do |num1| 
    num_2_divisors.each do |num2|
      common_divisors << num1 if num1 == num2
    end
  end

  return common_divisors.sum == 1
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
