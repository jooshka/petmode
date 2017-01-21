class Pet < ApplicationRecord
  has_attached_file :avatar, styles: { avatar: "219x200>", thumb: "120x120>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  belongs_to :user
  belongs_to :pet_type
  enum gender: ['male', 'female']

  def display_name
    name.empty? ? I18n.t('no name') : name
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
