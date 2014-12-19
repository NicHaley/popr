class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	validates :user_score, :presence => true
	validates :review, :presence => true
end
