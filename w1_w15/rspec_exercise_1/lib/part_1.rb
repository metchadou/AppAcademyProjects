def average(num1, num2)
  (num1 + num2) / 2.0
end

def average_array(numbers)
  numbers.sum / (numbers.length * 1.0)
end

def repeat(str, num)
  str * num
end

def yell(str)
  str.upcase + "!"
end

def alternating_case(sentence)
  new_sentence = []
  sentence.split.each_with_index do |word, idx|
    if idx % 2 == 0
      new_sentence << word.upcase
    else
      new_sentence << word.downcase
    end
  end
  new_sentence.join(" ")
end