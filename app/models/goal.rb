class Goal < ActiveRecord::Base
  validates :body, :user_id, presence: true

  after_initialize :set_default_completed

  belongs_to :user

  def set_default_completed
    self.completed ||= false
  end
end
