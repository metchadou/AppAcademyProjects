class Response < ApplicationRecord
  validates :respondent_id, uniqueness: {scope: :answer_choice_id, message: 'answer choice already selected'}
  validate :respondent_already_answered?, :answering_own_poll?

  belongs_to :answer_choice

  belongs_to :respondent,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  private

  def respondent_already_answered?
    if no_duplicate_response
      errors[:question] << 'has already been answered'
    end
  end

  def no_duplicate_response
    sibling_responses.exists?(respondent_id: self.respondent_id)
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def answering_own_poll?
    if is_author_and_respondent?
      errors[:respondent] << 'cannot respond to own poll'
    end
  end

  def is_author_and_respondent?
    poll_author_id = self.question.poll.author_id

    self.respondent_id == poll_author_id
  end
  
end