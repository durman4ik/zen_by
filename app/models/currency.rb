class Currency
  include Mongoid::Document

  field :sym,    type: String
  field :value,  type: String
  field :name,   type: String
  field :abbr,   type: String

  has_many       :tours
  has_one        :config

  validates :sym, :value, :name, :abbr, presence: {message: 'Поля выделенные красным должны быть заполнены!'}
  validates_numericality_of :value, message: 'Курс должен быть в числовом формате!'
end
