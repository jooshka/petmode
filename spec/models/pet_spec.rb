# == Schema Information
#
# Table name: pets
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  name                :string(255)
#  gender              :integer          default("male")
#  weight              :integer
#  about               :text(65535)
#  home_name           :string(255)
#  family              :integer
#

require 'rails_helper'

RSpec.describe Pet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
