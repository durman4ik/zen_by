class Template
  include Mongoid::Document

  field :name


  embedded_in :sticky_item
  embedded_in :page
end
