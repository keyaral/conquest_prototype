class User < ApplicationRecord
  has_many :activities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def assigned_activities
    Activity.where(assignee_id: self.id)
  end
  
  def total_score
    assigned_activities.sum(:score_value)
  end
  
  def set_default_role
    self.role ||= :user
  end
end
