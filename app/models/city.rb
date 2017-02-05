# == Schema Information
#
# Table name: cities
#
#  id               :integer          not null, primary key
#  region_id        :integer
#  locality_type_id :integer
#  name_ru          :string(255)
#  name_en          :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class City < ApplicationRecord
  belongs_to :region
  belongs_to :locality_type

  has_many :users
  has_many :adverts, through: :users
  has_many :pets, through: :adverts

  def title
    name = self["name_#{I18n.locale}"] || ''
    v = locality_type ? locality_type.title : ''
    v = v + ' ' + name if !name.empty?
    v = v + ', ' + region.title if region && region.title && !region.title.empty?
  end

  def self.search(term)
    where("LOWER(name_#{I18n.locale}) LIKE :term", term: "#{term.downcase}%")
   .order('name_en')
   .limit(30)
  end

  scope :have_pets, -> {
    joins(:pets)
    .order("name_#{I18n.locale}")
  }
end
