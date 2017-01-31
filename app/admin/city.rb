ActiveAdmin.register City do
  menu parent: 'References'
  permit_params :name_en, :name_ru, :locality_type_id, :region_id
end
