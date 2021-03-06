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
#  user_id     :integer
#

class Advert < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  enum advert_type: ['sale','copulation', 'goodhands']
  enum status: ['editing', 'moderation', 'published', 'rejected']

  has_one :city, through: :user
end
