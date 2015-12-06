class MenuItem
  include Mongoid::Document

  ATTACHMENT_TYPES  = %w(страница тур категория страна)
  FOR_MENU_STICKING = %w(категории страны)

  field :name,                        type:String
  field :position,                    type: Integer
  field :external_link,               type: String
  field :attachment_type,             type: String
  field :stick_to_menu,               type: String

  belongs_to :page
  belongs_to :tour
  belongs_to :category
  belongs_to :country
  has_many   :sub_menu_items, dependent: :destroy

  validates_associated :sub_menu_items
  validates :name, presence: { message: 'Имя должно быть заполнено!' }
  validate  :any_present?

  accepts_nested_attributes_for :sub_menu_items, allow_destroy: true #, reject_if: ->(a) { a.find_all {|x| x[1].blank?}.length >= 5 && a['_destroy'] == 'false' }

  def any_present?
    if %i(page_id country_id category_id tour_id external_link).all?{|a| self[a].blank?}
      self.errors.add :base, 'Необходимо выбрать назначение для пункта меню! Введите ссылку или выберите страницу/тур/категорию/страну!'
    end
  end
end
