def my_reject(arr, &prc)
  arr.select do |el|
    prc.call(el) == false
  end
end

def my_one?(arr, &prc)
  new_arr = arr.select do |el|
    prc.call(el) == true
  end  
  new_arr.length == 1
end

def hash_select(hash, &prc)
  new_hash = {}

  hash.each do |k, v|
    if prc.call(k, v) == true
      new_hash[k] = v
    end
  end

  new_hash
end

def xor_select(arr, prc1, prc2)
  arr.select do |el|
    (prc1.call(el) || prc2.call(el)) && !(prc1.call(el) && prc2.call(el))
  end
end

def proc_count(val, procs)
  count = 0
  procs.each do |prc|
    count += 1 if prc.call(val)
  end
  count
end