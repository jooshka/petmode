class Advert < ApplicationRecord
  belongs_to :pet
  enum advert_type: ['sale','copulation', 'goodhands']
  enum status: ['editing', 'moderation', 'published', 'rejected']
end
