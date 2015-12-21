class TaskItem
  include Mongoid::Document

  field :title

  embedded_in :travel_task, inverse_of: :task_items
end
