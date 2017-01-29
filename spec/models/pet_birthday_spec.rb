# == Schema Information
#
# Table name: pet_birthdays
#
#  id         :integer          not null, primary key
#  pet_id     :integer
#  day        :integer
#  month      :integer
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PetBirthday, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
