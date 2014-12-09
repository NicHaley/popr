class Event < ActiveRecord::Base
  has_one :movie
  belongs_to :host, class_name: "User"
  has_many :comments
  has_many :commitments
end
