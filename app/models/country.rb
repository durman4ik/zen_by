class Country
  include Mongoid::Document
  include Mongoid::Paperclip
  include ActionView::Helpers

  scope :sorted_by_name, -> { order_by(name: 'osc') }

  REGIONS = ['Австралия и Океания', 'Азия', 'Антарктида', 'Африка', 'Европа', 'Северная Америка', 'Южная Америка']

  attr_accessor :remove_image

  field :name, type: String
  field :title, type: String
  field :region, type: String
  field :description, type: String
  field :background_color, type: String, default: '#D0EAF5'
  field :meta_title, type: String
  field :meta_description, type: String
  field :meta_keywords, type: String
  field :slug, type: String

  index slug: 1

  has_mongoid_attached_file :image,
                            styles: {
                                thumb:     ['150x'],
                                preview:   ['400x'],
                                show:      ['600x'],
                                fix_height:['x230#']
                                  },
                            default_url: ':style/default_tour_background.jpg'
  do_not_validate_attachment_file_type :image

  has_one  :menu_item,          dependent: :destroy
  has_one  :sub_menu_item,      dependent: :destroy
  has_many :tours,              dependent: :destroy
  has_many :hotels,             dependent: :destroy

  before_validation :create_slug

  validates :region, inclusion: { in: REGIONS }
  validates_uniqueness_of :slug, { message: 'Такая сео ссылка уже существует. Создайте уникальную ссылку!' }



  def create_country(params)
    assign_attributes(params)
    set_meta(params)
    create_slug unless slug.present?
    save
  end

  def update_country(params)
    self.image = nil if params[:remove_image].present?
    update(params)
  end

  def set_meta(params)
    self.meta_description = strip_tags(params[:description]).delete("\n") unless params[:meta_description].present?
    self.meta_title = strip_tags(params[:title]).delete("\n") unless params[:meta_title].present?
  end

  private

    def create_slug
      (self.slug = name.to_slug.transliterate(:russian).gsub(' ', '-').downcase) unless slug.present?
    end
end
