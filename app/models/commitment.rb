class Commitment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :party_size, :numericality => { :only_integer => true, :greater_than => 0}
  validate :event_must_be_within_capacity

  # Validation medthod that calls the is_available? method from the event model
  # If a guest attempts to make a commitment that will exceed capacity of the event,
  # the validation fails

  def event_must_be_within_capacity
    unless self.event.is_available?(self.party_size)
      errors.add(:party_size, "Overcapacity")
    end
  end

  def guests
    if party_size
      if party_size > 1
        "+ " + (party_size - 1).to_s
      end
    end
  end

end
