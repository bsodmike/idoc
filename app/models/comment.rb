class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :documentation_page
  default_scope :order => "created_at ASC"
  named_scope :recent, :order => "created_at DESC"

  validates_presence_of :body, :message => "Comment cannot be blank"
end
