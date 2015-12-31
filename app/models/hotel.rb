class Hotel
  include Mongoid::Document

  attr_accessor :hotel_images

  field :title,              type: String
  field :stars,              type: String
  field :description,        type: String

  has_many :images,          dependent: :destroy
  has_many :days_in_hotels

  belongs_to :country


  validates_uniqueness_of :title, message: 'Отель с таким названием уже существует! Измените название отеля.'

  def tours
    Tour.in(id: days_in_hotels.map(&:tour_id))
  end

  def title_for_select
    "#{country.name} | #{title} #{stars}*"
  end

  def update_hotel(params)
    add_images_to_gallery(params)
    update(params)
  end

  def add_images_to_gallery(params)
    if params[:hotel_images].present?
      params[:hotel_images].each do |image|
        self.images.create(uploaded_file: image)
      end
    end
  end
end
