ActiveAdmin.register LocalityType do
  menu parent: 'References'
  permit_params :name_en, :name_ru
end
