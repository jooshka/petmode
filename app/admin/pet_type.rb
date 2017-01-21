ActiveAdmin.register PetType do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name do |pet|
      I18n.t(pet.name)
    end
    actions
  end

end
