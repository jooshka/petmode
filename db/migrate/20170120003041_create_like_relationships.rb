class CreateLikeRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :like_relationships do |t|
      t.references :user, index: true
      t.references :favorite
      t.references :follower
    end
  end
end
