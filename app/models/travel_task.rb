class TravelTask
  include Mongoid::Document

  field :title

  belongs_to :special_tour
  embeds_many :task_items, inverse_of: :travel_tasks

  accepts_nested_attributes_for :task_items, allow_destroy: true, reject_if: :all_blank
end
