# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  url        :string(255)      default("#")
#  text       :string(255)
#  icon       :string(255)
#  class_name :string(255)
#  kind       :integer
#  order_num  :integer
#  visible    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Menu < ApplicationRecord
  enum kind: [:head, :foot, :social, :partner]

  scope :visible, -> (kind) {
    where(visible: true, kind: kind)
   .order('order_num')
  }
end
