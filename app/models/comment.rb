class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :documentation_page

  validates_presence_of :body, :message => "Comment cannot be blank"
end
