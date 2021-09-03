def strange_sums(nums)
  count = 0
  pairs = nums.combination(2).to_a

  pairs.each { |pair| count += 1 if pair.first + pair.last == 0 }

  count
end

def pair_product(nums, product)
  pairs = nums.combination(2).to_a
  pairs.any? { |pair| pair.first * pair.last == product }
end

def rampant_repeats(str, hash)
  new_str = ""

  str.each_char do |ch|
    if hash.has_key?(ch)
      occurence = hash[ch]
      occurence.times do
        new_str += ch
      end
    else
      new_str += ch
    end
  end

  new_str
end

def perfect_square(num)
  (0..num).any? { |n| n * n == num }
end

def anti_prime?(num)
  num_factors = number_of_factors(num)

  (1...num).all? { |n| num_factors > number_of_factors(n) }
end

def number_of_factors(num)
  (1..num).count { |n| num % n == 0}
end

def matrix_addition(matrix_a, matrix_b)
  elements_length = matrix_a.first.length
  matrices_length = matrix_a.length

  (0...matrices_length).map do |ar|
    (0...elements_length).map do |i|
      ele_a = matrix_a[ar][i]
      ele_b = matrix_b[ar][i]
       ele_a + ele_b
    end
  end
end

def mutual_factors(*nums)
  common_factors = []
  
  i = 1
  while i <= nums.min
    common_factors << i if nums.all? { |num| num % i == 0 }
    i += 1
  end

  common_factors
end

def tribonacci_number(n)
  return 1 if n == 1 || n == 2
  return 2 if n == 3

  num1 = tribonacci_number(n-1)
  num2 = tribonacci_number(n-2)
  num3 = tribonacci_number(n-3)

  num1 + num2 + num3
end

def matrix_addition_reloaded(*matrices)
  height = matrices.first.length
  width = matrices.first.first.length
  matrices_sum = Array.new(height) { [0] * width }

  return nil if matrices.any? { |m| m.length != height || m.first.length != width }

  (0...height).each do |row|
    (0...width).each do |col|
      sum = 0
      matrices.each { |m| sum += m[row][col] }
      matrices_sum[row][col] = sum
    end
  end

  matrices_sum
end

def squarocol?(array)
  width = array.first.length

  array.each do |row|
    return true if row.all? { |el| row[0] == el }
  end

  (0...width).each do |col|
    return true if array.all? { |row| row[col] == array[0][col] }
  end

  false
end

def squaragonal?(arr)
  diag1 = (0...arr.length).map { |i| arr[i][i] }
  diag2 = (0...arr.length).map { |i| arr.reverse[i][i] }

  [diag1, diag2].any? { |diag| diag.uniq.length == 1 }
end

def pascals_triangle(n)
  height = n
  width = 0
  pyramid = Array.new(height) { [0] * width += 1 }

  (0...pyramid.length).each do |row_i|
    (0...pyramid[row_i].length).each do |col_i|
      if col_i == 0
        pyramid[row_i][col_i] = 1
      else
        previous1 = pyramid[row_i-1][col_i]
        previous2 = pyramid[row_i-1][col_i-1]
        if previous1 == nil
          previous1 = 0
        end
        pyramid[row_i][col_i] = previous1 + previous2
      end
    end
  end

  pyramid
end