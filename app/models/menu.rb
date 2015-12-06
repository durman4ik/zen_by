class Menu
  include Mongoid::Document
  has_many :menu_items, dependent: :destroy
end
