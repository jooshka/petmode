ActiveAdmin.register LikeRelationship do

  index do
    selectable_column
    id_column
    column :user
    column :favorite
    column :follower
    actions
  end

end
