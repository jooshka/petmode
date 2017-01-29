ActiveAdmin.register Pet do
  permit_params :name, :user_id, :avatar, :gender, :pet_type_id, :weight, :about

  index do
    selectable_column
    id_column
    column :user
    column :name do |pet|
      pet.display_name
    end
    column :pet_type do |pet|
      I18n.t(pet.pet_type.name)
    end
    column :gender do |pet|
      I18n.t(pet.gender)
    end
    column I18n.t('Age') do |pet|
      pet.birthday.age
    end
    column :avatar do |pet|
      image_tag(pet.avatar.url(:thumb))
    end
    column :weight do |pet|
      pet.display_weight
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :user
      f.input :name
      f.input :pet_type
      f.input :gender
      f.input :weight
      f.input :about, as: :text
    end
    f.actions
  end

end
