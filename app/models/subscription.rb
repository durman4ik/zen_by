class Subscription < Message

  attr_accessor :anti_spam

  field :email

  validates :anti_spam, length: { is: 0 }
end
