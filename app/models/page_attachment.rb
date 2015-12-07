class PageAttachment
  include Mongoid::Document

  field :template,          type: String
  field :position,          type: Integer

  belongs_to :page
end
