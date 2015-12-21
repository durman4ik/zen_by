class PageAttachment
  include Mongoid::Document

  attr_accessor :_destroy

  field :template,          type: String
  field :type

  belongs_to :sticky_item

  belongs_to :tour
  belongs_to :page
  belongs_to :category
  belongs_to :country

  validate :any_of

  def any_of
    if eval "self.#{self.type}_id.nil?"
      self.errors[:base] << 'В одном из прикреплений sticky меню ничего не было выбрано!'
    end
  end

end
