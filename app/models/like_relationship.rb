class LikeRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
