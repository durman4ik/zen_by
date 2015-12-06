class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  attr_accessor :anti_spam

  STATUSES = %w(новый одобрен отклонен просмотрен)

  scope :approved,            -> { where(status:     'одобрен') }

  before_validation :set_status
  validates :anti_spam, length: { is: 0 }
  validates :status, inclusion: { in: STATUSES }

  field :name,            type: String
  field :city,            type: String
  field :email,           type: String
  field :body,            type: String
  field :status,          type: String
  field :ip_address,      type: String

  has_mongoid_attached_file :image,
                            styles: {
                                thumb:     ['150x'],
                                average:   ['204x203#'],
                                preview:   ['400x'],
                                fix_height:['x230#']

                            },
                            default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image

  def set_city_and_ip(location)
    self.city = location.city
    self.ip_address = location.ip
  end

  def set_status
    self.status = 'новый' if self.new_record? && self.status.nil?
  end
end
