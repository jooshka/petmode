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

require 'rails_helper'

RSpec.describe Region, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
