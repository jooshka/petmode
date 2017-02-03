# == Schema Information
#
# Table name: pet_birthdays
#
#  id         :integer          not null, primary key
#  pet_id     :integer
#  day        :integer
#  month      :integer
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PetBirthday < ApplicationRecord
  belongs_to :pet

  validate :date_less_now?

  def date_less_now?
    today = Date.today
    res = true
    if year
      res &&= (year <= today.year)
      if res && month
        res &&= ((year == today.year && month <= today.month) || (year < today.year))
        if res && day
          Date.new(year,month,day) <= today
        end
      end
    end
    res
  end

  def age
    now = DateTime.now
    apx = "\u2245".encode('utf-8')
    if year
      d = day ? day : 1
      m = month ? month : 1
      b = DateTime.new(year,m,d)
      if month
        day ? Time.diff(b, now, '%y, %M, %w, %d')[:diff] : apx + Time.diff(b, now, '%y, %M')[:diff]
      else
        apx + Time.diff(b, now, '%y')[:diff]
      end
    else
      '--'
    end
  end

end
