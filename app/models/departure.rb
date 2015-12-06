class Departure
  include Mongoid::Document

  field :from,          type: String

  belongs_to :tour

  has_many :travel_groups, dependent: :destroy
  accepts_nested_attributes_for :travel_groups, allow_destroy: true,
                                reject_if: lambda {|a| a['start_date'].blank? || a['finish_date'].blank?}
end
