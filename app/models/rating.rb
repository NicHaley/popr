class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	validates :user_score, :presence => true
	validates :review, :presence => true
	validates :rt_id, presence: true, uniqueness: { scope: :user_id,
    message: "Already rated!" }
end
