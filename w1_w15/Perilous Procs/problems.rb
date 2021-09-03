def some?(arr, &prc)
  arr.each { |el| return true if prc.call(el) }
  false
end

def exactly?(arr, n, &prc)
  count = 0
  arr.each { |el| count += 1 if prc.call(el) }

  count == n
end

def filter_out(arr, &prc)
  new_arr = []
  arr.each { |el| new_arr << el if !prc.call(el) }
  new_arr
end

def at_least?(arr, n, &prc)
  count = 0
  arr.each { |el| count += 1 if prc.call(el) }
  count >= n
end


def every?(arr, &prc)
  arr.each { |el| return false if !prc.call(el) }
  true
end

def at_most?(arr, n, &prc)
  count = 0
  arr.each { |el| count += 1 if prc.call(el) }
  count <= n
end
def first_index(arr, &prc)
  arr.each_with_index { |el, idx| return idx if prc.call(el) }
  nil
end

def xnor_select(arr, prc1, prc2)
  new_arr = []
  arr.each do |el| 
    if prc1.call(el) == prc2.call(el)
      new_arr << el
    end
  end
  new_arr
end

def filter_out!(arr, &prc)
  arr.reject! { |el| prc.call(el) == true }
end

def multi_map(arr, n = 1, &prc)
  new_arr = arr
  i = 0
  while i < n
    new_arr.each_with_index do |el, i|
      new_arr[i] = prc.call(el)
    end
    i += 1
  end 
  new_arr
end

def proctition(arr, &prc)
  true_els = []
  false_els = []

  arr.each do |el|
    if prc.call(el)
      true_els << el
    else
      false_els << el
    end
  end

  [*true_els, *false_els]
end

def selected_map!(arr, prc1, prc2)
  arr.each_with_index do |el, i|
    if prc1.call(el)
      arr[i] = prc2.call(el)
    end
  end
  nil
end

def chain_map(val, procs)
  procs.each { |prc| val = prc.call(val) }
  val
end

def proc_suffix(sentence, suffixes) # 'dog cat'; {contains_a => 'ly', three_letters => 'o'}
  words = sentence.split # ['dog', 'cat']
  words.each_with_index do |word, i| # 'dog'
    original = word # original = 'dog'
    suffixes.each do |proc, suffix| # proc = three_letters ; v = 'o'
      if proc.call(original) # three_letters.call('dog')
        words[i] += suffix # 'dog' += 'o'
      end
    end
  end

  words.join(" ")
end

def proctition_platinum(array, *procs)
  trues = {}
  already_selected = []

  procs.each_index { |i| trues[i+1] = [] }
  array.each do |val| 
    procs.each_with_index do |proc, idx| 
      key = idx + 1
      if !already_selected.include?(val) 
        if proc.call(val) 
          trues[key] << val
          already_selected << val 
        end
      end
    end
  end

  trues
end

def procipher(sentence, procs)
  words = sentence.split 
  words.each_with_index do |word, i| 
    procs.each do |proc_k, proc_v| 
      if proc_k.call(word) 
        words[i] = proc_v.call(words[i]) 
      end
    end
  end

  words.join(" ")
end

def picky_procipher(sentence, procs)
  words = sentence.split 
  words.each_with_index do |word, i| 
    procs.each do |checker, changer| 
      if checker.call(word) 
        words[i] = changer.call(words[i]) 
        break
      end
    end
  end

  words.join(" ")
end

is_yelled = Proc.new { |s| s[-1] == '!' }
is_upcase = Proc.new { |s| s.upcase == s }
contains_a = Proc.new { |s| s.downcase.include?('a') }
make_question = Proc.new { |s| s + '???' }
reverse = Proc.new { |s| s.reverse }
add_smile = Proc.new { |s| s + ':)' }

p picky_procipher('he said what!',
    is_yelled => make_question,
    contains_a => reverse
) # "he dias what!???"

p picky_procipher('he said what!',
    contains_a => reverse,
    is_yelled => make_question
) # "he dias !tahw"

p picky_procipher('he said what!',
    contains_a => reverse,
    is_yelled => add_smile
) # "he dias !tahw"

p picky_procipher('stop that taxi now',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "stop that??? taxi??? now"

p picky_procipher('STOP that taxi!',
    is_upcase => add_smile,
    is_yelled => reverse,
    contains_a => make_question
) # "STOP:) that??? !ixat"