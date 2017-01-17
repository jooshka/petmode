ActiveAdmin.register Pet do
  permit_params :name, :user_id, :avatar

  index do
    selectable_column
    id_column
    column :name
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
    end
    f.actions
  end

end
