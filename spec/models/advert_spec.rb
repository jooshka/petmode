# == Schema Information
#
# Table name: adverts
#
#  id          :integer          not null, primary key
#  pet_id      :integer
#  advert_type :integer
#  price       :decimal(10, 2)
#  status      :integer
#  comment     :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Advert, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
