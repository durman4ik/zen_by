class StickyItem
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title
  field :full_title
  field :link

  belongs_to :page
  belongs_to :home_page

  has_many    :page_attachments, dependent: :destroy
  embeds_many :templates,        inverse_of: :sticky_items
  embeds_many :html_contents,        inverse_of: :sticky_items

  validates_associated :page_attachments

  accepts_nested_attributes_for :templates,        allow_destroy: true
  accepts_nested_attributes_for :page_attachments, allow_destroy: true
  accepts_nested_attributes_for :html_contents,    allow_destroy: true
end
