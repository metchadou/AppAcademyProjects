# PROBLEM 1 : Multiples of 3 or 5
def multiples_sum(num1, num2, target)
  mltps = (0...target).select do |mltp|
    mltp % num1 == 0 || mltp % num2 == 0  
  end
  mltps.sum
end

# PROBLEM 2 : Even Fibonacci numbers

def even_fibs_sum
  seq = [1]
  next_fib = 2

  until next_fib > 4000000
    seq << next_fib
    next_fib = seq.last(2).sum
  end
  seq.select(&:even?).sum
end

# PROBLEM 3: Largest prime factor

def is_prime?(num)
  (2...num).each {|f| return false if num % f == 0 }
  num >= 2
end

def largest_prime_factor(num)
  (1...num).reverse_each do |f|
    if num.odd?
      if num % f == 0
        return f if is_prime?(f)
      end
    end
  end
end

# PROBLEM 4: Largest palindrome
def largest_palindrome
  palindromes = []
  (100..999).reverse_each do |num1|
    (100..999).reverse_each do |num2|
      prdct = num1 * num2
      palindromes << prdct if prdct.to_s.split("") == prdct.to_s.split("").reverse
    end
  end
  palindromes.max
end

# PROBLEM 5: smallest multiple
def smallest_multiple
  num = 20
  found_num = false

  while !found_num
    num += 1
    if num.to_s.end_with?("0")
      if (1..20).all? {|f| num % f == 0}
        found_num = true
      end
    end
  end
  num
end

# PROBLEM 6
def sum_sqr_dif
  nums = (1..100).to_a

  # sum of each square
  sqrs = nums.map {|num| num * num}
  sqrs_sum = sqrs.sum

  # square of total sum
  sum = nums.sum
  sum_sqr = sum * sum

  # difference
  dif = sum_sqr - sqrs_sum
  dif
end

# PROBLEM 7
def ten_thd_first_prime
  primes = [2]
  num = 3
  while primes.length < 10001
    if num.odd?
      primes << num if is_prime?(num)
    end
    num += 1
  end
  primes.last
end

# PROBLEM 8 : Largest_product in a series
def larg_prdct_in_series
  f = File.open("thd_digit_num.txt")
  serie = f.readlines.join("").split("").map!(&:to_i)
  serie_last_idx = serie.length - 1
  indices = (-1..11).to_a
  prdcts = {}

  until indices.last == serie_last_idx
    indices.map!{|i| i + 1}
    nums = indices.map {|i| serie[i]}
    prdct = nums.inject(1, :*)
    prdcts[nums] = prdct
  end
  prdcts.max_by(&:last).last
end
