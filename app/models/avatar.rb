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

class Avatar < ApplicationRecord
  has_attached_file :img, styles: { lg: '228>', md: '130>', sm: '75>' }, default_url: "/assets/missing.svg"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/

  belongs_to :imageable, polymorphic: true
end
