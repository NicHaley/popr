class User < ActiveRecord::Base
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

end

