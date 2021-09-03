require "byebug"
#Problem 1: 

def sum_recur(array)
  return 0 if array.empty?
  return array[0] if array.length == 1

  sum_recur(array[0...-1]) + array[-1]
end

# p sum_recur([1,2,3,4,5])
# p sum_recur([0,-4])
# p sum_recur([100])
# p sum_recur([])

#Problem 2: 

def includes?(array, target)
  return false if array.empty?
  return true if array.last == target

  includes?(array[0...-1], target)
end

# p includes?([4,5,3],9)
# p includes?([8,5,0,4],0)

# Problem 3: 

def num_occur(array, target)
  return 0 if array.empty?

  count = 0
  count+= 1 if array.last == target

  count + num_occur(array[0...-1], target)
end

# p num_occur([1,1,1,1],1)
# p num_occur([10,111,99,8],8)
# p num_occur([1,2,3,4],5)

# Problem 4: 

def add_to_twelve?(array)
  return false if array.length <= 1
  return true if array[0] + array[1] == 12

  add_to_twelve?(array[1..-1])
end

# p add_to_twelve?([4,8,3,5])
# p add_to_twelve?([6,4,6,8])
# p add_to_twelve?([0,5,4,9,3,0])

# Problem 5: 

def sorted?(array)
  return true if array.length == 1
  return false if array[0] > array[1]

  sorted?(array[1..-1])
end

# p sorted?([4,5,6,9,10])
# p sorted?([10,15,10,20])

# Problem 6: 

def reverse(string)
  debugger
  return string if string.length <= 1

  string[-1] + reverse(string.slice(1, string.length - 2)) + string[0]
end

p reverse("duck")
# p reverse("anana")
# p reverse("reverse")