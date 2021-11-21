require_relative 'questions_db'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  attr_accessor :id, :follower_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL

    data.map {|datum| QuestionFollow.new(datum)}
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id,
        users.fname,
        users.lname
      FROM
        users
      JOIN
        question_follows ON question_follows.follower_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    data.map {|datum| User.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.author_id
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        question_follows.follower_id = ?
    SQL

    data.map {|datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id,
        questions.title,
        questions.body,
        questions.author_id
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        question_follows.question_id
      ORDER BY
        COUNT(question_follows.question_id) DESC
      LIMIT
        ?
    SQL

    data.map {|datum| Question.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end
end