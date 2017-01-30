# == Schema Information
#
# Table name: pets
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  name                :string(255)
#  gender              :integer          default("male")
#  weight              :integer
#  about               :text(65535)
#  home_name           :string(255)
#  family              :integer
#

class Pet < ApplicationRecord
  has_attached_file :avatar, styles: { avatar: "219x200>", thumb: "120x120>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :user
  enum family: ['cat', 'dog']
  enum gender: ['male', 'female']
  has_one :advert
  has_one :birthday, class_name: 'PetBirthday'
  accepts_nested_attributes_for :birthday

  def display_name
    name && name.empty? ? I18n.t('no name') : name
  end

  def display_weight
    if weight
      weight<1000 ? "#{weight} #{I18n.t('g')}" : "#{weight/1000.0} #{I18n.t('kg')}"
    else
      I18n.t('undefined')
    end
  end

  before_validation do |pet|
    pet.name.try(:strip!)
  end

end
