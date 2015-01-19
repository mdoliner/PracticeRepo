require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

class Question
  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(
      'SELECT * FROM questions WHERE id = ?', id
    ).first

    Question.new(question)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(
      'SELECT * FROM questions WHERE user_id = ?', author_id
    )

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options = { "id" => nil })
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def create
    raise 'Already created.' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
      INSERT INTO
        questions(title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def save
    if id.nil?
      create
    else
      QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id, id)
        UPDATE
          questions
        SET
          title = ?, body = ?, user_id =?
        WHERE
          id = ?
      SQL
    end
    id
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollower.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end


end

class User
  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(
      'SELECT * FROM users WHERE id = ?', id
    ).first

    User.new(user)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(
      'SELECT * FROM users WHERE fname = ? AND lname = ?', fname, lname
    ).first

    User.new(user)
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options = { "id" => nil })
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def create
    raise 'Already created.' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def save
    if id.nil?
      create
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
        SQL
    end
    id
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    questions = Question.find_by_author_id(id)
    num_likes = questions.inject(0) { |sum, question| sum += question.num_likes }

    questions.length / num_likes.to_f

  end

end

class Reply
  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(
      'SELECT * FROM replies WHERE id = ?', id
    ).first

    Reply.new(reply)
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(
      'SELECT * FROM replies WHERE question_id = ?', question_id
    )

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(
      'SELECT * FROM replies WHERE user_id = ?', user_id
    )

    replies.map { |reply| Reply.new(reply) }
  end

  attr_accessor :body, :user_id, :question_id, :parent_reply_id
  attr_reader :id

  def initialize(options = { "id" => nil, "parent_reply_id" => nil})
    @id = options["id"]
    @body = options["body"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
    @parent_reply_id = options["parent_reply_id"]
  end

  def create
    raise 'Already created.' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, body, user_id, question_id, parent_reply_id)
      INSERT INTO
        replies(body, user_id, question_id, parent_reply_id)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def save
    if id.nil?
      create
    else
      QuestionsDatabase.instance.execute(<<-SQL, body, user_id, question_id, parent_reply_id, id)
        UPDATE
          replies
        SET
          body = ?, user_id = ?, question_id = ?, parent_reply_id =?
        WHERE
          id = ?
        SQL
    end
    id
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_reply_id) unless parent_reply_id.nil?
  end

  def child_replies
    child_replies = QuestionsDatabase.instance.execute(
      'SELECT * FROM replies WHERE parent_reply_id = ?', id
    )

    child_replies.map { |reply| Reply.new(reply) }
  end

end

class QuestionFollower

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        question_followers AS qf
      INNER JOIN
        users AS u ON u.id = qf.user_id
      WHERE
        qf.question_id = ?
    SQL

    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        question_followers AS qf
      INNER JOIN
        questions AS q ON q.id = qf.question_id
      WHERE
        qf.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        q.*
      FROM
        question_followers AS qf
      INNER JOIN
        questions AS q ON (qf.question_id = q.id)
      GROUP BY
        q.id
      ORDER BY
        COUNT(q.id) DESC
      LIMIT ?
    SQL

    questions.map { |question| Question.new(question) }
  end

end

class QuestionLike
  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        users AS u
      INNER JOIN
        question_likes AS ql
      ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
    SQL

    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id).first
      SELECT
        COUNT(*)
      FROM
        question_likes AS ql
      WHERE
        ql.question_id = ?
      GROUP BY
        ql.question_id
    SQL

    num_likes.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        questions AS q
      INNER JOIN
        question_likes AS ql
      ON q.id = ql.question_id
      WHERE
        ql.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        q.*
      FROM
        questions AS q
      INNER JOIN
        question_likes AS ql
      ON
        q.id = ql.question_id
      GROUP BY
        q.id
      ORDER BY
        COUNT(q.id) DESC
      LIMIT ?
    SQL

  end

end


# module Saveable
#   def save
#     if id.nil?
#       create
#     else
#       fields = self.instance_variables
#       updates = fields.map { |field| "#{field.to_s[1..-1]} = #{instance_variable_get(field)}" }.join(", ")
#       result =
#       files.map { |field| update[field] = instance_variable_get(field) }
#       updates.each do |field, value|
#         QuestionsDatabase.instance.execute(<<-SQL, update_code, id)
#           ?
#           WHERE
#             id = ?
#         SQL
#       end
#     end
#
#
#   end
#
# end
