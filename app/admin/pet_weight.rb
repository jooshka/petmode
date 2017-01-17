ActiveAdmin.register PetWeight do
  permit_params :user_id, :pet_id, :weight, :date

  index do
    selectable_column
    id_column
    column :user
    column :pet
    column :weight
    column :date
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :user
      f.input :pet
      f.input :weight
      f.input :date
    end
    f.actions
  end

end
