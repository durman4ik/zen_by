class Tour
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActionView::Helpers
  include Mongoid::Paperclip

  attr_accessor :gallery_images
  attr_accessor :remove_image

  field :name,                                        type: String
  field :city,                                        type: String
  field :route,                                       type: String
  field :map_link,                                    type: String
  field :description,                                 type: String
  field :details,                                     type: String
  field :price_description,                           type: String
  field :days,                                        type: String
  field :days_remark,                                 type: String
  field :price,                                       type: Integer
  field :hotels_remark,                               type: String
  field :show_hotels_with_date,                       type: String, default: true
  field :group_tour,                                  type: Boolean
  field :use_in_slider,                               type: Boolean, default: false

  # seo
  field :meta_title,                                  type: String
  field :meta_description,                            type: String
  field :meta_keywords,                               type: String
  field :slug,                                        type: String

  index slug: 1

  belongs_to                                          :country
  belongs_to                                          :currency

  has_and_belongs_to_many                             :categories

  has_one  :menu_item,                                dependent: :destroy
  has_one  :sub_menu_item,                            dependent: :destroy
  has_many :sliders,                                  dependent: :destroy
  has_many :images,                                   dependent: :destroy
  has_many :videos,                                   dependent: :destroy
  has_many :days_in_hotels,                           dependent: :destroy
  has_many :travel_days,                              dependent: :destroy
  has_many :departures,                               dependent: :destroy
  has_many :faqs,                                     dependent: :destroy
  has_many :price_includes,                           dependent: :destroy
  has_many :price_not_includes,                       dependent: :destroy
  has_many :orders

  accepts_nested_attributes_for :sliders,             allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :faqs,                allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :travel_days,         allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :price_includes,      allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :price_not_includes,  allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :days_in_hotels,      allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :departures,          allow_destroy: true, reject_id: ->(a) { a['from'].blank? }
  accepts_nested_attributes_for :videos,              allow_destroy: true, reject_if: ->(a) { a['video_id'].blank? }

  validates_uniqueness_of :slug, { message: 'Такая сео ссылка уже существует. Создайте уникальную ссылку!' }

  has_mongoid_attached_file     :image,
                                styles: {
                                    thumb:     ['150x'],
                                    average:   ['204x203#'],
                                    preview:   ['400x'],
                                    fix_height:['x230#']

                                },
                                default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image

  def hotels
    Hotel.in(id: days_in_hotels.map(&:hotel_id))
  end

  def create_tour(params)
    assign_attributes(params)
    set_meta(params)
    create_slug unless slug.present?
    save
  end

  def update_tour(params)
    self.image = nil if params[:remove_image].present?
    add_images_to_tour_gallery(params)
    update(params)
  end

  def add_images_to_tour_gallery(params)
    if params[:gallery_images].present?
      params[:gallery_images].each do |image|
        self.images.create(uploaded_file: image)
      end
    end
  end

  def set_meta(params)
    if params[:description].present?
      self.meta_description = strip_tags(params[:description]).delete("\n") unless params[:meta_description].present?
    end
    if params[:name].present?
      self.meta_title = strip_tags(params[:name]).delete("\n") unless params[:meta_title].present?
    end
  end

  def title_for_orders
    "#{country.name} | #{name}"
  end

  private
    def create_slug
      self.slug = name.to_slug.transliterate(:russian).gsub(' ', '-').gsub(':', '-').downcase
    end
end
