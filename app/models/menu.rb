class Menu < ApplicationRecord
  enum kind: [:head, :foot, :social, :partner]

  scope :visible, -> (kind) {
    where(visible: true, kind: kind)
   .order('order_num')
  }
end
