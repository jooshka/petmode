# == Schema Information
#
# Table name: avatars
#
#  id               :integer          not null, primary key
#  imageable_type   :string(255)
#  imageable_id     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  img_file_name    :string(255)
#  img_content_type :string(255)
#  img_file_size    :integer
#  img_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Avatar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
