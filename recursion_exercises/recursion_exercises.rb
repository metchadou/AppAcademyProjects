require "byebug"

# WARMUP

def range(start, finish)
  return [] if start >= finish

  [start] + range(start + 1, finish)
end

# Test cases
# p range(5, 5)
# p range(1, 5)
# p range(-8, 0)

def sum(ary)
  return 0 if ary == []

  ary.last + sum(ary[0...-1])
end

# Test cases
# p sum([-5,0,4,2])
# p sum([0,70,0])
# p sum([])

# EXPONENTIATION

def exponent_v1(base, power)
  return 1 if power == 0

  smaller_exponent = power - 1
  base_to_smaller_exponent = exponent_v1(base, smaller_exponent)

  base * base_to_smaller_exponent
end

# p exponent_v1(0,1)
# p exponent_v1(5,3)
# p exponent_v1(1,0)
# p exponent_v1(4,3)
# p exponent_v1(-7,2)

def exponent_v2(base, power)
  return 1 if power == 0
  return base if power == 1

  if power.even?
    exponent_half = power / 2
    base_to_exponent_half = exponent_v2(base, exponent_half)
    base_to_exponent_half * base_to_exponent_half
  else
    smaller_exponent = power - 1
    smaller_exponent_half = smaller_exponent / 2
    base_to_smaller_exponent_half = exponent_v2(base, smaller_exponent_half)
    squared_base_smaller_to_exponent_half = base_to_smaller_exponent_half * base_to_smaller_exponent_half
    base * squared_base_smaller_to_exponent_half
  end
end

# p exponent_v1(0,1)
# p exponent_v1(5,3)
# p exponent_v1(1,0)
# p exponent_v1(4,3)
# p exponent_v1(-7,2)

# DEEP DUP

class Array

  def deep_dup
    return self.dup if self.none? {|el| el.is_a?(Array)}

    deep_dupped = []
    self.each do |el|
      if el.is_a?(Array)
        deep_dupped << el.deep_dup
      else
        deep_dupped << el
      end
    end

    deep_dupped
  end
  
end

# FIBONACCI

def fibonacci(seq_length)
  return [] if seq_length <= 0
  return [1] if seq_length == 1
  return [1, 1] if seq_length == 2

  smaller_seq_length = seq_length - 1
  smaller_seq_last_num = fibonacci(smaller_seq_length)[-1]
  smaller_seq_second_to_last_num = fibonacci(smaller_seq_length)[-2]

  fibonacci(smaller_seq_length) + [smaller_seq_last_num + smaller_seq_second_to_last_num]
end

# p fibonacci(1)
# p fibonacci(2)
# p fibonacci(3)
# p fibonacci(4)
# p fibonacci(5)
# p fibonacci(10)

def fibonacci_iter(seq_length)
  return [] if seq_length <= 0
  return [1] if seq_length == 1
  return [1, 1] if seq_length == 2

  seq = [1, 1]

  until seq.length == seq_length
    seq_last_num = seq[-1]
    seq_second_to_last_num = seq[-2]
    seq << seq_last_num + seq_second_to_last_num
  end

  seq
end

# p fibonacci_iter(0)
# p fibonacci_iter(-4)
# p fibonacci_iter(1)
# p fibonacci_iter(2)
# p fibonacci_iter(5)
# p fibonacci_iter(10)

def bsearch(nums, target)
  return nil if nums.empty?

  mid_idx = nums.length / 2
  mid_num = nums[mid_idx]

  case target <=> mid_num
  when -1
    bsearch(nums.take(mid_idx), target)
  when 0
    mid_idx
  when 1
    sub_answer = bsearch(nums.drop(mid_idx+1), target)
    sub_answer.nil? ? nil : (mid_idx + 1) + sub_answer
  end
end

# bsearch([1, 2, 3], 1) # => 0
# bsearch([2, 3, 4, 5], 3) # => 1
# bsearch([2, 4, 6, 8, 10], 6) # => 2
# bsearch([1, 3, 4, 5, 9], 5) # => 3
# bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge(nums_a, nums_b)
  merged = []
  n_ab = nums_a.length + nums_b.length

  until merged.length == n_ab
    first_a = nums_a.first
    first_b = nums_b.first
    if first_a == nil
      merged += nums_b
    elsif first_b == nil
      merged += nums_a
    else
      case first_a <=> first_b
      when -1
        merged << first_a
        nums_a.shift
      when 0
        merged << first_a
        nums_a.shift
      when 1
        merged << first_b
        nums_b.shift
      end
    end
  end
  merged
end

def merge_sort(nums)
  n = nums.length
  
  if n == 1 || nums.empty?
    return nums
  end

  half = n/2
  first_half, second_half = nums.take(half), nums.drop(half)
  sorted_first_half, sorted_second_half = merge_sort(first_half), merge_sort(second_half)

  merge(sorted_first_half, sorted_second_half)
end

# p merge_sort([4,2,88,6,40,15,2])
# p merge_sort([-4,-2,-8,0])
# p merge_sort([1,2,3,4,5])

def subsets(ary)
  return [[]] if ary.empty?

  subs = []
  n = ary.length
  combs = ary.combination(n-1)

  combs.each do |comb|
    subs += subsets(comb)
  end

  subs += [ary]
  subs.uniq
end

# subsets([]) # => [[]]
# subsets([1]) # => [[], [1]]
# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def greedy_make_change(amount, coins)
  return [] if amount == 0

  change = []
  biggest_coin = coins.find{|coin| (amount - coin) >= 0}
  remaining_amount = amount - biggest_coin
  change += [biggest_coin] + greedy_make_change(remaining_amount, coins)
  
  change
end

# p greedy_make_change(20, [10,10])
# p greedy_make_change(10, [10,10])
# p greedy_make_change(24, [10,7,1])

# def make_better_change(amount, coins)
#   return [] if amount <= 0

#   possible_changes = []
#   change = []

#   coins.each do |coin|
#     if amount - coin >= 0
#       change << coin
#       smaller_coins = coins.select {|c| c <= coin}
#       amount -= coin
#       change += make_better_change(amount, smaller_coins)
#       possible_changes += [change]
#     end
#   end

#   possible_changes.min
# end

# p make_better_change(24, [10,7,1])
# p make_better_change(20, [5])

def permutations(ary)
  if ary.length == 1 || ary.empty?
    return [ary]
  end

  all_permutations = []

  ary.each_with_index do |el, i|
    other_els = ary[0...i] + ary[i+1..-1]
    permutation = permutations(other_els)
    all_permutations += permutation.map {|perm| perm.unshift(el)}
  end

  all_permutations
end

# p permutations([1,2])
# p permutations([1,2,3])
# p permutations([1,2,3,4,5])

def make_better_change(amount, coins)
  return [] if amount == 0

  best_change = nil

  coins.each do |coin|
    next if coin > amount

    change_for_rest = make_better_change(amount - coin, coins)
    change = [coin] + change_for_rest

    if best_change.nil? || change.length < best_change.length
      best_change = change
    end
  end

  best_change
end

p make_better_change(20,[5,10,15])
p make_better_change(24,[10,7,1])
p make_better_change(25,[10,15,5,20])