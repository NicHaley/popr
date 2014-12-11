class Event < ActiveRecord::Base
  has_one :movie_interest
  belongs_to :host, class_name: "User"
  has_many :comments
  has_many :commitments

  validates :title, :presence => true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  # Function to verify if requested party size of commitment being made
  # falls within the event capacity set by the host.

  def is_available?(party_size)
    confirmed = self.commitments.sum(:party_size)
    self.capacity - (confirmed + party_size) >= 0
  end
end
