class DaysInHotel
  include Mongoid::Document

  field :days

  belongs_to :hotel
  belongs_to :tour
end
