class Page
  include Mongoid::Document
  include ActionView::Helpers

  scope :with_position,     -> { order_by(menu_position: 'OSC') }
  scope :parents,   -> { where(is_parent: true) }

  FOR_BODY_STICKING = %w(категории страны отзывы)

  before_validation       :create_slug
  validates_uniqueness_of :slug, message: 'Такая сео ссылка уже существует. Создайте уникальную сео ссылку!'
  validates_presence_of   :slug, message: 'Поле "сео ссылка" обязательно к заполнению!'

  field :title,                       type: String
  field :show_title,                  type: Boolean, default: true
  field :description,                 type: String
  field :html_content,                type: String
  field :stick_to_body,               type: String
  field :meta_title,                  type: String
  field :meta_description,            type: String
  field :meta_keywords,               type: String
  field :description_background,      type: String,  default: '#fff'
  field :slug,                        type: String

  index slug: 1

  has_one :menu_item,                 dependent: :destroy
  has_one :sub_menu_item,             dependent: :destroy

  def update_page(page_params)
    self.assign_attributes(page_params)
    self.assign_attributes(parent: nil) if page_params[:is_parent]
    set_position(page_params)
    save
  end

  def set_position(page_params)
    if page_params[:top_level] && page_params[:menu_position] && (page_params[:menu_position] != self.menu_position)
      update_position(page_params[:menu_position])
    end
  end

  def update_position(position)
    pages = Page.parents.positioned
    pages.each_with_index do |page, index|
    end
  end

  def set_meta(params)
    self.meta_description = strip_tags(params[:description]).delete("\n") unless params[:meta_description].present?
    self.meta_title = strip_tags(params[:title]).delete("\n") unless params[:meta_title].present?
  end

  def subpages
    Page.where(parent: self.title)
  end

  def stickers
    case self.stick_to_menu
      when 'категории' then Category.all
      when 'страны' then Country.all
    end
  end

  private
    def create_slug
      (self.slug = title.to_slug.transliterate(:russian).gsub(' ', '-').downcase) if !slug.present? && title.present?
    end
end
