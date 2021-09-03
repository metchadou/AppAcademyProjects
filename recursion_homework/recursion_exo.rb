require "byebug"

def sum_to(n)
  return nil if n < 0
  return 1 if n == 1
  
  n + sum_to(n-1)
end

# Test Cases
# puts sum_to(5)  # => returns 15
# puts sum_to(1)  # => returns 1
# puts sum_to(9)  # => returns 45
# puts sum_to(-8)  # => returns nil

def add_numbers(ary)
  return nil if ary.length == 0
  return ary.first if ary.length == 1

  ary.first + add_numbers(ary[1..-1])
end

# Test Cases
# add_numbers([1,2,3,4]) # => returns 10
# add_numbers([3]) # => returns 3
# add_numbers([-80,34,7]) # => returns -39
# add_numbers([]) # => returns nil

def factorial(n)
  return nil if n < 0
  return 1 if n <= 1

  n * factorial(n-1)
end

def gamma_fnc(n)
  factorial(n-1)
end

# Test Cases
# gamma_fnc(0)  # => returns nil
# gamma_fnc(1)  # => returns 1
# gamma_fnc(4)  # => returns 6
# gamma_fnc(8)  # => returns 5040

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?

  if flavors.pop == favorite
    true
  else
    ice_cream_shop(flavors, favorite)
  end
end

# Test Cases
# ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
# ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
# ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
# ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
# ice_cream_shop([], 'honey lavender')  # => returns false

def reverse(string)
  return "" if string == ""

  reverse(string[1..-1]) + string[0]
end

# Test Cases
# reverse("house") # => "esuoh"
# reverse("dog") # => "god"
# reverse("atom") # => "mota"
# reverse("q") # => "q"
# reverse("id") # => "di"
# reverse("") # => ""