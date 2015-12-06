module ApplicationHelper
  def convert_boolean(value)
    return content_tag(:span, class: 'badge bg-green') { 'Да' } if value
    content_tag(:span, class: 'badge bg-red') { 'Нет' }
  end

  def review_status(value)
    case value
      when 'одобрен'    then content_tag(:span, class: 'label label-success') { 'Одобрен' }
      when 'новый'      then content_tag(:span, class: 'label label-danger')  { 'Новый' }
      when 'отклонен'   then content_tag(:span, class: 'label label-inverse') { 'Отклонен' }
      when 'просмотрен' then content_tag(:span, class: 'label label-info')    { 'Просмотрен' }
    end
  end

  def check_travel_group(group, options = {})
    start = group.start_date
    finish = group.finish_date
  end

  def show_price(tour)
    @tour_currency = tour.currency
    if @tour_currency == @config.currency
      "#{tour.price } #{tour.currency.name}"
    else
      "#{number_with_delimiter(tour.price * @config.currency.value)} #{@config.currency.sym}"
    end
  end
end
