require 'rails_helper'

RSpec.describe Event, :type => :model do
	it "ensures the time is made after Time.now" do
		event = build(:event)
		event.time = Time.now.yesterday

		event.valid?
		expect(event.errors.full_messages.include?("can't start in the past")).to be_true
	end

end
