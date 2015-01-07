class MovieInterest < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :rt_id, presence: true, uniqueness: { scope: :user_id,
    message: "Already wished!" }
  
end
