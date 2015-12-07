class Category
  include Mongoid::Document
  include Mongoid::Paperclip
  include ActionView::Helpers

  scope :sorted_by_name, -> { order_by(name: 'osc') }
  scope :showed_on_main, -> { where(show_on_main: true).order_by(name: 'osc') }

  before_validation :create_slug

  validates_uniqueness_of :slug, { message: 'Такая сео ссылка уже существует. Создайте уникальную ссылку!' }

  attr_accessor :remove_image

  field :name,                  type: String
  field :title,                 type: String
  field :description,           type: String
  field :background_color,      type: String, default: '#D0EAF5'
  field :show_on_main,          type: Boolean

  field :meta_title,            type: String
  field :meta_description,      type: String
  field :meta_keywords,         type: String
  field :slug,                  type: String

  index slug: 1

  has_one  :menu_item,          dependent: :destroy
  has_one  :sub_menu_item,      dependent: :destroy
  has_many :sliders,            dependent: :destroy

  has_and_belongs_to_many       :tours
  accepts_nested_attributes_for :sliders, allow_destroy: true, reject_if: :all_blank

  has_mongoid_attached_file :image,
                            styles: {
                                thumb:     ['150x'],
                                preview:   ['400x'],
                                show:      ['600x'],
                                fix_height:['x230#']
                            },
                            default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image

  def create_category(params)
    assign_attributes(params)
    set_meta(params)
    create_slug unless slug.present?
    save
  end

  def update_category(params)
    self.image = nil if params[:remove_image].present?
    update(params)
  end

  def set_meta(params)
    self.meta_description = strip_tags(params[:description]).delete("\n").truncate(150) unless params[:meta_description].present?
    self.meta_title = strip_tags(params[:title]).delete("\n").truncate(50) unless params[:meta_title].present?
  end

  private

    def create_slug
      (self.slug = name.to_slug.transliterate(:russian).downcase.gsub(' ', '-')) unless slug.present?
    end
end
