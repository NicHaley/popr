class Event < ActiveRecord::Base
  has_one :movie_interest
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_many :comments
  has_many :commitments

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  	def available(party_size)
		confirmed = commitments.sum(party_size)
		party_size <= (capacity - confirmed)
	end
end
