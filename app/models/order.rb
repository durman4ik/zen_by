class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification

  STATUSES = %w(новый обработан подтвержден отклонен)

  attr_accessor :anti_spam

  field :name,            type: String
  field :email,           type: String
  field :phone,           type: String
  field :city,            type: String
  field :message,         type: String
  field :status,          type: String, default: 'новый'

  validates :anti_spam, length: { is: 0 }
  # validates :status, inclusion: { in: STATUSES, message: 'Не входит в список разрешенных вариантов!' }

  belongs_to :tour

end
