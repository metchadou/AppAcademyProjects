def reverser(string, &proc)
  proc.call(string.reverse)
end

def word_changer(sentence, &proc)
  words = sentence.split(" ")
  new_words = []
  words.each { |word| new_words << proc.call(word)}
  new_words.join(" ")
end

def greater_proc_value(num, proc_1, proc_2)
  if proc_1.call(num) > proc_2.call(num)
    return proc_1.call(num)
  else
    return proc_2.call(num)
  end
end

def and_selector(array, proc_1, proc_2)
  selected = []
  array.each { |ele| selected << ele if proc_1.call(ele) && proc_2.call(ele) }
  selected
end

def alternating_mapper(array, proc_1, proc_2)
  mapped = []
  array.each_with_index do |ele, idx|
    if idx.even?
      mapped << proc_1.call(ele)
    else
      mapped << proc_2.call(ele)
    end
  end
  mapped
end