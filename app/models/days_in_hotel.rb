class DaysInHotel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :days

  embeds_one :html_content, inverse_of: :days_in_hotel

  belongs_to :hotel
  belongs_to :tour

  accepts_nested_attributes_for :html_content
end
