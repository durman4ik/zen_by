class Page
  include Mongoid::Document
  include ActionView::Helpers

  FOR_BODY_STICKING =
          %w(Категории categories_page),
          %w(Страны countries_page),
          %w(Отзывы reviews_page),
          ['Информация о нас',                          'about_page'],
          ['Наши контакты',                             'contacts_page'],
          # %w(Вакансии vacancies_page),
          ['Причины путешествовать с нами (текст)',     'causes_text_page'],
          ['Причины путешествовать с нами (картинки)',  'causes_images_page'],
          ['Корпоративные туры (командообразование)',   'teambuilding_tours'],
          ['Корпоративные туры (поощрительные)',        'gift_tours'],
          ['Self Travel туры',                          'self_travel_tours'],
          ['Форма подписки',                            'subscribe_form'],
          ['Форма для отзывов',                         'new_review_form'],
          ['Форма обратного звонка',                    'callback_form'],
          ['Форма предварительного рассчета',           'pre_count_form']


  before_validation       :create_slug
  validates_uniqueness_of :slug, message: 'Такая сео ссылка уже существует. Создайте уникальную сео ссылку!'
  validates_presence_of   :slug, message: 'Поле "сео ссылка" обязательно к заполнению!'

  field :title,                       type: String
  field :show_title,                  type: Boolean, default: true
  field :description,                 type: String
  field :html_content,                type: String
  field :stick_to_body,               type: String
  field :meta_title,                  type: String #page_attachments_attributes html_contents_attributes
  field :meta_description,            type: String
  field :meta_keywords,               type: String
  field :description_background,      type: String,  default: '#fff'
  field :slug,                        type: String

  index slug: 1

  has_one  :menu_item,                 dependent: :destroy
  has_one  :sub_menu_item,             dependent: :destroy
  has_many :sticky_items,              dependent: :destroy
  embeds_many :templates,              inverse_of: :pages

  accepts_nested_attributes_for        :sticky_items,     allow_destroy: true
  accepts_nested_attributes_for        :templates, allow_destroy: true,
                                       reject_if: ->(a) { a['name'].blank? }

  def set_meta(params)
    if params[:description].present?
      self.meta_description = strip_tags(params[:description]).delete("\n") unless params[:meta_description].present?
    end
    self.meta_title = strip_tags(params[:title]).delete("\n") unless params[:meta_title].present?
  end

  private
    def create_slug
      (self.slug = title.to_slug.transliterate(:russian).gsub(' ', '-').downcase) if !slug.present? && title.present?
    end
end
