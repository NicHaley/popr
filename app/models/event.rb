class Event < ActiveRecord::Base
  has_one :movie_interest
  belongs_to :host, class_name: "User"
  has_many :comments
  has_many :commitments
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # Function to verify if requested party size of commitment being made
  # falls within the event capacity set by the host.

  def is_available?(party_size)
    confirmed = self.commitments.sum(:party_size)
    self.capacity - (confirmed + party_size) >= 0
  end

  def attendees
    @attendees =[]
    self.commitments.each {|c| @attendees << c.user if c.id}
    @attendees
  end

  validate :ensure_dates

  def ensure_dates
    if(time < Time.now)
      errors.add(:time, "can't start in the past")
    end
  end

end
