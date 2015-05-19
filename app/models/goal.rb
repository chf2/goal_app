class Goal < ActiveRecord::Base
  include Commentable

  validates :body, :user_id, presence: true

  after_initialize :set_default_completed

  belongs_to :user

  has_many :cheers
  has_many :cheerers, through: :cheers

  def set_default_completed
    self.completed ||= false
  end
end
