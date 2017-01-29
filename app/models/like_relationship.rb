# == Schema Information
#
# Table name: like_relationships
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  favorite_id :integer
#  follower_id :integer
#

class LikeRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
