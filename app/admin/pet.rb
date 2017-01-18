ActiveAdmin.register Pet do
  permit_params :name, :user_id, :avatar, :gender_id

  index do
    selectable_column
    id_column
    column :name
    column :gender
    column :user
    column :avatar do |pet|
      image_tag(pet.avatar.url(:thumb))
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :user
      f.input :gender_id
    end
    f.actions
  end

end
