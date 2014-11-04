class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  
  has_many :goals
  has_many :comments, as: :commentable
  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :user_id,
    primary_key: :id
  )
   
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password
    @password
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def generate_token
    SecureRandom.base64(16)
  end
  
  def reset_session_token!
    self.session_token = generate_token
    self.save
    self.session_token
  end
  
  def public_goals
    goals.where(top_secret: false)
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= generate_token
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end
  
end
