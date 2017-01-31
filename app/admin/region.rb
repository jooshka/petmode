ActiveAdmin.register Region do
  menu parent: 'References'
  permit_params :name_en, :name_ru, :locality_type_id, :country_id
end
