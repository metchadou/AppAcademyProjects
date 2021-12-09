# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do 

  u1 = User.create!(username: 'momotorres')
  u2 = User.create!(username: 'kimson')

  p1 = Poll.create!(title: 'poll 1', author_id: u1.id)
  p2 = Poll.create!(title: 'poll 2', author_id: u2.id)

  q1 = Question.create!(text: 'question 1', poll_id: p1.id)
  q2 = Question.create!(text: 'question 2', poll_id: p1.id)
  q3 = Question.create!(text: 'question 3', poll_id: p2.id)
  q4 = Question.create!(text: 'question 4', poll_id: p2.id)

  ac_1a = AnswerChoice.create!(text: 'Answer choice 1a', question_id: q1.id)
  ac_1b = AnswerChoice.create!(text: 'Answer choice 1b', question_id: q1.id)
  ac_2a = AnswerChoice.create!(text: 'Answer choice 2a', question_id: q2.id)
  ac_2b = AnswerChoice.create!(text: 'Answer choice 2b', question_id: q2.id)
  ac_3a = AnswerChoice.create!(text: 'Answer choice 3a', question_id: q3.id)
  ac_3b = AnswerChoice.create!(text: 'Answer choice 3b', question_id: q3.id)
  ac_4a = AnswerChoice.create!(text: 'Answer choice 4a', question_id: q4.id)
  ac_4b = AnswerChoice.create!(text: 'Answer choice 4b', question_id: q4.id)

  Response.create!(respondent_id: u2.id, answer_choice_id: ac_1b.id)
  Response.create!(respondent_id: u2.id, answer_choice_id: ac_2a.id)
  Response.create!(respondent_id: u1.id, answer_choice_id: ac_3a.id)
  Response.create!(respondent_id: u1.id, answer_choice_id: ac_4a.id)

end