class PriceInclude
  include Mongoid::Document

  field :title

  belongs_to :tour
end
