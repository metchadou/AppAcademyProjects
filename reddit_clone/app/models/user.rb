class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: { message: "is required"}, uniqueness: { message: "already exists" }
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "is required" }
  validates :password, length: { minimum: 6, message: "is too short. Use at least 6 characters" }, allow_nil: true

  after_initialize :ensure_session_token

  has_many :subs,
    foreign_key: :moderator_id,
    dependent: :destroy
  
  has_many :posts,
    foreign_key: :author_id,
    dependent: :destroy

  has_many :comments,
    foreign_key: :author_id,
    inverse_of: :author,
    dependent: :destroy

  def post_author?(post_id)
    self.post_ids.include?(post_id)
  end
  
    def sub_moderator?(sub_id)
    self.sub_ids.include?(sub_id)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
end
