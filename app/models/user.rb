class User < ActiveRecord::Base
  has_many :hosted_events, class_name: "Event", foreign_key: 'host_id'   
  has_many :comments#, through: :events
  has_many :commitments
  has_many :movie_interests
  has_many :ratings

  mount_uploader :avatar, AvatarUploader

	has_many :friendships
	has_many :friends, through: :friendships

	has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
	has_many :inverse_friends, through: :inverse_friendships, source: :user
	
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  def is_friend?(user)
    if self.friendships.find_by(friend_id: user.id)
      self.friendships.find_by(friend_id: user.id).confirm
    else
      false
    end
  end

  def incoming_friendships
    Friendship.where(friend_id: self.id, confirm: false)
  end

  def self.search(query)
    where("first_name like ?", "%#{query}%") 
  end
end

