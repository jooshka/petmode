# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name_ru    :string(255)
#  name_en    :string(255)
#  iso        :string(255)
#  iso3       :string(255)
#  iso_num    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ApplicationRecord
end
