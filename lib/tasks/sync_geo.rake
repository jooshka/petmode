require 'net/http'

desc "Sync Geohelper"
task sync_geo: :environment  do
  begin
    puts 'Countries...'
    page = 1
    begin
      url = URI.parse("http://geohelper.info/api/v1/countries?apiKey=o1G5I6YpGdOQEamQcTVjYSa6JVbo2ama&locale[lang]=ru&pagination[page]=#{page}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
      r = JSON.parse(res.body)
      countries = r['result']
      countries.each do |i|
        item = {
          id: i['id'],
          iso: i['iso'],
          iso3: i['iso3'],
          iso_num: i['isoNumeric'],
          name_en: i['localizedNames']['en'],
          name_ru: i['localizedNames']['ru']
        }
        Country.find_or_initialize_by(id: item[:id]).update_attributes!(item)
      end
      total_page = r['pagination']['totalPageCount']
      page = page + 1
    end while page <= total_page

    puts 'Regions...'
    page = 1
    begin
      url = URI.parse("http://geohelper.info/api/v1/regions?apiKey=o1G5I6YpGdOQEamQcTVjYSa6JVbo2ama&locale[lang]=ru&pagination[limit]=100&pagination[page]=#{page}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
      r = JSON.parse(res.body)
      regions = r['result']
      regions.each do |i|
        locality_type_id = nil
        if i.has_key?('localityType')
          name_en = i['localityType']['localizedNames']['en']
          name_ru = i['localityType']['localizedNames']['ru']
          locality_type = LocalityType.find_or_initialize_by(name_en: name_en)
          locality_type.update_attributes!(name_en: name_en, name_ru: name_ru)
          locality_type_id = locality_type.id
        end
        country_id = nil
        if i['codes'].has_key?('iso')
          country = Country.find_by(iso:  i['codes']['iso'].split('-')[0])
          country = Country.find_by(iso3: i['codes']['iso'].split('-')[0]) unless country
          country_id = country.id if country
        end
        item = {
          id: i['id'],
          country_id: country_id,
          locality_type_id: locality_type_id,
          name_en: i['localizedNames']['en'],
          name_ru: i['localizedNames']['ru']
        }
        Region.find_or_initialize_by(id: item[:id]).update_attributes!(item)
      end
      total_page = r['pagination']['totalPageCount']
      print "\rPage ", page, "/", total_page
      page = page + 1
    end while page <= total_page
    puts

    puts 'Cities...'
    page = 1
    begin
      url = URI.parse("http://geohelper.info/api/v1/cities?apiKey=o1G5I6YpGdOQEamQcTVjYSa6JVbo2ama&locale[lang]=ru&pagination[limit]=100&pagination[page]=#{page}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
      r = JSON.parse(res.body)
      regions = r['result']
      regions.each do |i|
        locality_type_id = nil
        if i.has_key?('localityType')
          name_en = i['localityType']['localizedNames']['en']
          name_ru = i['localityType']['localizedNames']['ru']
          locality_type = LocalityType.find_or_initialize_by(name_en: name_en)
          locality_type.update_attributes!(name_en: name_en, name_ru: name_ru)
          locality_type_id = locality_type.id
        end
        item = {
          id: i['id'],
          region_id: i['regionId'],
          locality_type_id: locality_type_id,
          name_en: i['localizedNames']['en'],
          name_ru: i['localizedNames']['ru']
        }
        City.find_or_initialize_by(id: item[:id]).update_attributes!(item)
      end
      total_page = r['pagination']['totalPageCount']
      print "\rPage ", page, "/", total_page
      page = page + 1
    end while page <= total_page
    puts

  end
end
