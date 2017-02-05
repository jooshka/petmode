# == Schema Information
#
# Table name: regions
#
#  id               :integer          not null, primary key
#  country_id       :integer
#  locality_type_id :integer
#  name_ru          :string(255)
#  name_en          :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Region < ApplicationRecord
  belongs_to :country
  belongs_to :locality_type

  has_many :cities
  has_many :users, through: :cities
  has_many :adverts, through: :users
  has_many :pets, through: :adverts

  def title
    v = self["name_#{I18n.locale}"] || ''
    v = v + ' '  + locality_type.title if locality_type && locality_type.title && !locality_type.title.empty?
    v = v + ', ' + country.title if country && country.title && !country.title.empty?
  end

  scope :have_pets, -> {
    joins(:pets)
    .order("name_#{I18n.locale}")
  }

end
