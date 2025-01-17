class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  
  has_one_attached :profile_image

  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 10 },
    uniqueness: true

  validates :information,
    length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
