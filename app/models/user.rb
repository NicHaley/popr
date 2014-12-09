class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

	has_many :friendships
	has_many :friends, through: :friendships
	
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
end
