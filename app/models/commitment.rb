class Commitment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validate :event_must_be_within_capacity
  # validates :user_id, uniqueness: { scope: :event_id,
  #   message: "can't commit to an event more than once" }

  
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
