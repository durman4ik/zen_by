class SpecialTour
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Paperclip

  TYPES = ['Командообразование', 'Поощрительная поездка', 'Self Travel пример']

  attr_accessor :remove_image

  field :name,            type: String
  field :region,          type: String
  field :city,            type: String
  field :route,           type: String
  field :description,     type: String
  field :price,           type: String
  field :group_size,      type: String
  field :days,            type: String
  field :tour_type,       type: String
  field :country,         type: String

  belongs_to :currency
  has_many   :travel_tasks, dependent: :destroy

  embeds_one :calendar

  accepts_nested_attributes_for :calendar
  accepts_nested_attributes_for :travel_tasks, allow_destoy: true, reject_if: :all_blank

  has_mongoid_attached_file     :image,
                                styles: {
                                    thumb:     ['150x'],
                                    average:   ['204x155#'],
                                    preview:   ['400x'],
                                    corporate: ['204x170']
                                },
                                default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image


  def update_tour(params)
    assign_attributes(params)
    self.image = nil if params[:remove_image] == 'true'
    save
  end
end
