class Goal < ActiveRecord::Base
  validates :goal, presence: true
  validates :top_secret, inclusion: { in: [false, true] }
  
  belongs_to(
    :achiever,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  after_initialize :ensure_top_secret
  
  private
  
  def ensure_top_secret
    self.top_secret ||= false
  end
end
