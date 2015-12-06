class TravelGroup
  include Mongoid::Document
  STATUSES = ['Идет набор', 'Группа набрана']

  field :start_date,      type: String
  field :finish_date,     type: String
  field :active,          type: Boolean

  belongs_to :departure
end
