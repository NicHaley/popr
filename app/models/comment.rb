class Comment < ActiveRecord::Base
  validates :content, :presence => true

  belongs_to :user
  belongs_to :event

  def pretty_date
    self.created_at.strftime("%b %d, %Y")
  end
end
