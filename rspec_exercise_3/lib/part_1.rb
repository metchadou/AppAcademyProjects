def is_prime?(num)
  return false if num < 2

  (2...num).each { |f| return false if num % f == 0 }
  
  true
end

def nth_prime(n)
  pos = 0
  prime = 0
  while pos != n
    prime += 1
    pos += 1 if is_prime?(prime)
  end

  prime
end

def prime_range(min, max)
  (min..max).select { |num| is_prime?(num) }
end