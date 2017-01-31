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

require 'rails_helper'

RSpec.describe LocalityType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
