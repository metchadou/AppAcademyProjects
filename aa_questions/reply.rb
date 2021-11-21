require_relative 'questions_db'
require_relative 'user'
require_relative 'question'

class Reply
  attr_accessor :id, :body, :author_id, :subject_question_id, :parent_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    data.map {|datum| Reply.new(datum)}
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL

    data.map {|datum| Reply.new(datum)}
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question_id = ?
    SQL

    data.map {|datum| Reply.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @author_id = options['author_id']
    @subject_question_id = options['subject_question_id']
    @parent_id = options['parent_id']
  end

  def author
    User.find_by_id(self.author_id)
  end

  def question
    Question.find_by_id(self.subject_question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    data.map {|datum| Reply.new(datum)}
  end

  def create
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.body, self.author_id, self.subject_question_id, self.parent_id)
      INSERT INTO
        replies (body, author_id, subject_question_id, parent_id)
      VALUES
        (?, ?, ?, ?)
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.body, self.author_id, self.subject_question_id, self.parent_id, self.id)
      UPDATE
        replies
      SET
        body = ?, author_id = ?, subject_question_id = ?, parent_id = ?
      WHERE
        id = ?
    SQL
  end

end