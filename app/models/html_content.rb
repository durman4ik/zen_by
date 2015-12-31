class HtmlContent
  include Mongoid::Document

  attr_accessor :_destroy

  field :content, type: String

  embedded_in :sticky_item
  embedded_in :days_in_hotel
end
