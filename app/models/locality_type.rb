# == Schema Information
#
# Table name: locality_types
#
#  id         :integer          not null, primary key
#  name_en    :string(255)
#  name_ru    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LocalityType < ApplicationRecord

  def title
    v = self["name_#{I18n.locale}"] || ''
    v.downcase
  end

end
