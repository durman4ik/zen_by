class Currency
  include Mongoid::Document

  field :sym,    type: String
  field :value,  type: Integer
  field :name,   type: String
  field :abbr,   type: String

  has_many       :tours
  has_one        :config
end
