class HtmlContent
  include Mongoid::Document

  attr_accessor :_destroy

  field :content, type: String

  belongs_to :sticky_item
end
