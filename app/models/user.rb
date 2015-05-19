class User < ActiveRecord::Base
  include Commentable

  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many :cheerings, class_name: "Cheer"
  has_many :cheered_goals, through: :cheerings, source: :goal
  has_many :goals
  has_many :authored_comments, class_name: "Comment", foreign_key: :author_id

  after_initialize :ensure_session_token, :set_num_cheers

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def set_num_cheers
    self.cheers ||= 5
  end
end
