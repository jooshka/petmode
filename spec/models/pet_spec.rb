# == Schema Information
#
# Table name: pets
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  name       :string(255)
#  gender     :integer          default("male")
#  weight     :integer
#  about      :text(65535)
#  home_name  :string(255)
#  family     :integer          default("cat")
#

require 'rails_helper'

RSpec.describe Pet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
