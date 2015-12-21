class PreCount < Message

  attr_accessor :anti_spam

  field :name
  field :phone
  field :email
  field :country
  field :date
  field :days
  field :group
  field :message

  validates :anti_spam, length: { is: 0 }

end
