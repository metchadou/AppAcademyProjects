class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll

  has_many :answer_choices

  has_many :responses,
    through: :answer_choices,
    source: :responses

  

  def results
    responses_count = {}

    acs = self
      .answer_choices
      .select('answer_choices.text, COUNT(responses.id) AS responses_count')
      .left_outer_joins(:responses)
      .group('id')

    acs.each do |ac|
      responses_count[ac.text] = ac.responses_count
    end

    responses_count
  end
  
  def results_SQL
    acs = AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.text, COUNT(responses.id) AS responses_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    results = {}
    acs.each do |ac|
      results[ac.text] = ac.responses_count
    end

    results
  end
  
  def results_2_queries
    responses_count = {}
    
    answer_choices = self.answer_choices.includes(:responses)
    answer_choices.each do |answer_choice|
      responses_count[answer_choice.text] = answer_choice.responses.length
    end

    responses_count
  end
  
end