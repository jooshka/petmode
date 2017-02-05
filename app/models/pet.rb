# == Schema Information
#
# Table name: pets
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  name       :string(255)
#  gender     :integer          default("male")
#  weight     :integer
#  about      :text(65535)
#  home_name  :string(255)
#  family     :integer          default("cat")
#

class Pet < ApplicationRecord
  has_one :avatar, as: :imageable, dependent: :destroy
  belongs_to :user
  enum family: ['cat', 'dog']
  enum gender: ['male', 'female']
  has_one :advert, dependent: :destroy
  has_one :birthday, class_name: 'PetBirthday', dependent: :destroy

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :birthday
  accepts_nested_attributes_for :advert

  validates_associated :birthday

  has_one :city, through: :advert
  has_one :region, through: :city
  has_one :country, through: :region

  def display_name
    name && !name.empty? ? name : I18n.t('anonym')
  end

  def display_home_name
    home_name && !home_name.empty? ? home_name : '--'
  end

  def display_weight
    if weight
      weight<1000 ? "#{weight} #{I18n.t('g')}" : "#{weight/1000.0} #{I18n.t('kg')}"
    else
      '--'
    end
  end

  def display_birth
    birthday ? "#{birthday.day}-#{'%02d' % birthday.month if birthday.month}-#{birthday.year}" : ""
  end

  def lock?
    advert && !advert.editing?
  end

  scope :without_advert_or_copulation, -> {
    left_joins(:advert)
    .where('advert_type is null or advert_type=1')
  }

  scope :advert, -> {
   joins(:advert)
  }

  scope :sale, -> {
    joins(:advert) #&& advert.published?
   .where('adverts.advert_type': Advert.advert_types['sale'])
  }

  scope :goodhands, -> {
    joins(:advert) #&& advert.published?
   .where('adverts.advert_type': Advert.advert_types['goodhands'])
  }

  scope :copulation, -> {
    joins(:advert) #&& advert.published?
   .where('adverts.advert_type': Advert.advert_types['copulation'])
  }

  scope :by_gender, -> gender { where(gender: gender) }
  scope :by_family, -> family { where(family: family) }
  scope :by_city,   -> city_id { joins(:city).where('cities.id' => city_id ) }
  scope :by_region, -> region_id { joins(:region).where('regions.id' => region_id ) }
  scope :by_country,-> country_id { joins(:country).where('countries.id' => country_id ) }

  scope :by_price,  -> started_at, ended_at {
    joins(:advert)
   .where("adverts.price >= ? AND adverts.price <= ?", started_at, ended_at)
  }

  before_validation do |pet|
    pet.name.try(:strip!)
  end

  after_create do |pet|
    pet.build_avatar.save unless pet.avatar
  end

end
