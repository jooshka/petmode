class PetBirthday < ApplicationRecord
  belongs_to :pet

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
      I18n.t('undefined')
    end
  end

end
