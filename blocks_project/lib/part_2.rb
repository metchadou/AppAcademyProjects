def all_words_capitalized?(words)
  words.all?{ |word| word.capitalize == word }
end

def no_valid_url?(urls)
  urls.none? { |url| url.end_with?('.com', '.net', '.io', '.org') }
end

def any_passing_students?(students)
  students.any? do |student|
    student[:grades].sum / student[:grades].length >= 75
  end
end

students_1 = [
  { name: "Alvin", grades: [70, 50, 75] },
  { name: "Warlin", grades: [80, 99, 95] },
  { name: "Vlad", grades: [100] },
]
students = [
  { name: "Alice", grades: [60, 68] },
  { name: "Bob", grades: [20, 100] }
]
p any_passing_students?(students_1)
p any_passing_students?(students)