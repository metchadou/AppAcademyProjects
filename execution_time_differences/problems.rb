require "byebug"
# Time complexity = O(n^2)
def quadratic_my_min(nums)
  nums.each_with_index do |num1, i1|
    min_num = true

    nums.each_with_index do |num2, i2|
      next if i1 == i2
      min_num = false if num1 > num2
    end

    return num1 if min_num
  end
end

# Time complexity = O(n)
def linear_my_min(nums)
  min = nums.first

  nums.each {|num| min = num if min > num}

  min
end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# puts linear_my_min(list)  # =>  -5

def linear_largest_contiguous_subsum(list)
  subarrays = []

  list.each_with_index do |num, i|
    subarrays << [num]

    j = i + 1
    while j < list.length
      subarrays << list[i..j]

      j += 1
    end
  end

  subarrays.map(&:sum).max
end

def largest_contiguous_subsum(list)
  largest_sum = list.first

  list.each_with_index do |num, i|
    j = i
    while j < list.length
      current_sum = list[i..j].sum
      largest_sum = current_sum if current_sum > largest_sum

      j += 1
    end
  end

  largest_sum
end

# puts largest_contiguous_subsum([5, 3, -7]) # => 8
# puts largest_contiguous_subsum([2, 3, -6, 7, -6, 7]) # => 8 (from [7, -6, 7])
# puts largest_contiguous_subsum([-5, -1, -3]) # => -1 (from [-1])

def largest_contiguous_subsum2(arr)
  debugger
  largest = arr.first
  current = arr.first

  (1...arr.length).each do |i|
    current = 0 if current < 0
    current += arr[i]
    largest = current if current > largest
  end

  largest
end

largest_contiguous_subsum2([-5, 3, -7, 10, 10, -2]) # => 8