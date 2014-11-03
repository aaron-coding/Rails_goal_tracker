class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  
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
  
  private
  
  def ensure_session_token
    self.session_token ||= generate_token
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return if user.nil? || !(user.is_password?(password))
    user
  end
  
end
