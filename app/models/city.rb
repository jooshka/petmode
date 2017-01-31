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

  def description
    d = ''
    if self
      d = d + locality_type["name_#{I18n.locale}"].downcase if locality_type && locality_type["name_#{I18n.locale}"]
      d = d + ' ' + self["name_#{I18n.locale}"] if self["name_#{I18n.locale}"]
      if region
        if region["name_#{I18n.locale}"] != self["name_#{I18n.locale}"]
          d = d + ', ' + region["name_#{I18n.locale}"] if region["name_#{I18n.locale}"]
          d = d + ' '  + region.locality_type["name_#{I18n.locale}"].downcase if region.locality_type && region.locality_type["name_#{I18n.locale}"]
        end
        d = d + ', ' + region.country["name_#{I18n.locale}"] if region.country && region.country["name_#{I18n.locale}"]
      end
    end
    d
  end

  def self.search(term)
    where("LOWER(name_#{I18n.locale}) LIKE :term", term: "#{term.downcase}%")
   .order('name_en')
   .limit(30)
  end
end
