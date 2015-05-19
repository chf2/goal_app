class Comment < ActiveRecord::Base
  validates :author_id, :commentable_id, :commentable_type, :body, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
end
