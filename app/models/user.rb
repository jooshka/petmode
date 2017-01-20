class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { avatar: "219x200>", icon: "75x75>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :pets

  has_many :like_relationships
  has_many :favorites, through: :like_relationships, class_name: 'User'
  has_many :followers, through: :like_relationships, class_name: 'User'

  def liked?(user)
    self.favorites.find_by(id: user.id)
  end

  def like(user)
    unless liked?(user)
      self.favorites << user
      user.followers << self
    end
  end

  def fio
    "#{last_name} #{first_name} #{patronymic}".strip
  end

  def full_name
    "#{last_name} #{first_name}".strip
  end
end
