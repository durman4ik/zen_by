class CallsBack < Message

  attr_accessor :anti_spam

  field :name,      type: String
  field :phone,     type: String
  field :message,   type: String

  validates :anti_spam, length: { is: 0 }

end
