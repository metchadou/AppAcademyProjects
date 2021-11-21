require_relative 'questions_db'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'

class User
  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")

    data.map {|datum| User.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    data.map {|datum| User.new(datum)}
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
        AND lname = ?
    SQL

    data.map {|datum| User.new(datum)}
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  # join version
  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        (CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT questions.id))
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        question_likes.question_id = (
          SELECT
            id
          FROM
            questions
          WHERE
            author_id = ?)
    SQL

    data.first.values.first
  end

  # subqueries version
  def average_karma_subqueries
    data = QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.fname, self.lname)
      SELECT
        CAST( 
          ( SELECT
              COUNT(*)
            FROM
              question_likes
            WHERE
              question_id = (
                SELECT
                  id
                FROM
                  questions
                WHERE
                  author_id = (
                    SELECT
                      id
                    FROM
                      users
                    WHERE
                      fname = ?
                      AND lname = ?
                  )
              )
          ) AS FLOAT) / (
            SELECT
              COUNT(*)
            FROM
              questions
            WHERE
              author_id = (
                SELECT
                  id
                FROM
                  users
                WHERE
                  fname = ?
                  AND lname = ?
              )
          )
    SQL

    data.first.values.first
  end

  def create
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

end