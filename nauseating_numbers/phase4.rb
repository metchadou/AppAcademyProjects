def is_prime?(num)
  (2...num).each { |f| return false if num % f == 0 }

  num > 1
end

def mersenne_prime(n)
  nth_mersenne = 0

  i = 2
  while nth_mersenne < n
    candidate = (2**i) - 1
    nth_mersenne += 1 if is_prime?(candidate)
    return candidate if nth_mersenne == n
    i += 1
  end
end

def triangular_number?(num)
  triangular_num = 1

  i = 1
  while triangular_num < num
    triangular_num = (i * (i + 1)) / 2
    return true if triangular_num == num

    i += 1
  end

  false
end

def triangular_word?(word)
  alphabet = ("a".."z").to_a

  indices_sum = word
      .split("")
      .map { |letter| alphabet.index(letter) + 1 }
      .sum

  triangular_number?(indices_sum)
end

def adjacent_nums?(num1, num2)
  num1 == num2 + 1 || num2 == num1 + 1
end

def consecutive_collapse(nums) #[3, 4, 1]
  collapsed = false

  while !collapsed # true
    collapsed = true

    i = 0
    while i < nums.length - 1 # i < 2
      a = nums[i] # a = 3
      b = nums[i+1] # b = 4
      if adjacent_nums?(a, b) # true
        idx = nums.index(a) # index_a = 0
        2.times { nums.delete_at(idx) }
        collapsed = false
        break
      end
      i += 1
    end
  end

  nums
end

def pretentious_primes(nums, n)
  nums.each_with_index do |num, idx|
    if n > 0
      i = num + 1
      nth_prime = 0

      while nth_prime != n
        nth_prime += 1 if is_prime?(i)
        nums[idx] = i if nth_prime == n 
        i += 1
      end
    else
      i = num - 1
      nth_prime = 0

      while nth_prime != n
        if i < 2
          i = nil
          nums[idx] = i
          break
        end
        nth_prime -= 1 if is_prime?(i) # i = 3
        nums[idx] = i if nth_prime == n
        i -= 1 # i = 2
      end
    end
  end

  nums
end

p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]