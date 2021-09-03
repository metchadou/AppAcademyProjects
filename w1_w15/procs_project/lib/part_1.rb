def my_map(array, &proc)
  new_array = []
  array.each { |ele| new_array << proc.call(ele) }
  new_array
end 

def my_select(array, &proc)
  new_array = []
  array.each { |ele| new_array << ele if proc.call(ele) == true}
  new_array
end

def my_count(array, &proc)
  count = 0
  array.each { |ele| count += 1 if proc.call(ele) == true }
  count
end

def my_any?(array, &proc)
  array.each { |ele| return true if proc.call(ele) == true }
  false
end

def my_all?(array, &proc)
  array.each { |ele| return false if proc.call(ele) == false }
  true
end

def my_none?(array, &proc)
  array.each { |ele| return false if proc.call(ele) == true }
  true
end

