# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  last_name              :string(255)
#  first_name             :string(255)
#  patronymic             :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  about                  :text(65535)
#  breeder                :boolean
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  city_id                :integer
#  phone                  :string(255)
#  site                   :string(255)
#

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
  belongs_to  :city

  def like?(user)
    self.favorites.find_by(id: user.id)
  end

  def like(user)
    unless like?(user)
      self.transaction do
        self.favorites << user
        user.followers << self
      end
    end
    like?(user)
  end

  def unlike(user)
    if like?(user)
      self.transaction do
        self.favorites = self.favorites.to_a - [user]
        user.followers = user.followers.to_a - [self]
      end
    end
    !like?(user)
  end

  def display_name
    "#{last_name} #{first_name}".strip
  end
end
