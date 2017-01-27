ActiveAdmin.register Menu do
  permit_params :kind, :text, :url, :icon, :class_name, :order_num, :visible

end
