def proper_factors(num)
  factors = []

  (1...num).each { |f| factors << f if num % f == 0 }

  factors
end

def aliquot_sum(num)
  proper_factors(num).sum
end

def perfect_number?(num)
  aliquot_sum(num) == num
end

def ideal_numbers(n)
  ideal_nums = []
  count = 0
  
  i = 1
  while count < n
    if perfect_number?(i)
      ideal_nums << i
      count += 1
    end

    i += 1
  end

  ideal_nums
end