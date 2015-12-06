class SubMenuItem
  include Mongoid::Document

  field :name,            type:String
  field :position,        type: Integer
  field :external_link,   type: String
  field :attachment_type, type: String

  belongs_to :menu_item
  belongs_to :page
  belongs_to :tour
  belongs_to :country
  belongs_to :category

  validates :name, presence: {message: 'Поле "Название" должно быть заполнено!'}
  validate :any_present?

  def any_present?
    if %i(page_id country_id category_id tour_id external_link).all?{|a| self[a].blank?}
      self.menu_item.errors.add :base, 'Необходимо выбрать назначение для пункта меню! Введите ссылку или выберите страницу/тур/категорию/страну!'
    end
  end
end
