class Faq
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title,           type: String
  field :description,     type: String

  belongs_to :tour
  belongs_to :home_page
end
