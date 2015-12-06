class TravelDay
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor                 :_destroy

  field :day_number,            type: String
  field :description,           type: String
  field :title,                 type: String

  belongs_to :tour
  has_many   :images,           dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: ->(a) { a['uploaded_file'].blank? }, allow_destroy: true
end