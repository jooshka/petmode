json.array!(@cities) do |city|
  json.id           city.id
  json.name         city["name_#{I18n.locale}"]
  json.description  city.title
end
