class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { avatar: "219x200>", icon: "75x75>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :pets

  def fio
    "#{last_name} #{first_name} #{patronymic}".strip
  end

  def full_name
    "#{last_name} #{first_name}".strip
  end
end
