module ApplicationHelper
  def convert_boolean(value)
    return content_tag(:span, class: 'label label-success') { 'Да' } if value
    content_tag(:span, class: 'label label-danger') { 'Нет' }
  end

  def convert_messages_type(type)
    case type
      when 'Subscription' then 'Подписка'
      when 'Order'        then 'Заказ'
      when 'CallsBack'    then 'Обратный звонок'
      when 'PreCount'     then 'Рассчет стоимости'
    end
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
    start = group.start_date.to_date
    today = Date.today
    if (today - start).to_i >= -7 && (today - start).to_i <= 0 && group.active
      group_status('rgb(49, 149, 191)', 'Последние места')
    elsif today - start < -7 && group.active
      group_status('rgb(0, 153, 51)', 'Идет набор')
    else
      group_status('rgb(204, 0, 0)', 'Группа набрана')
    end
  end

  def show_price(tour)
    @tour_currency = tour.currency
    if @tour_currency == @config.currency
      "#{number_with_delimiter tour.price } #{tour.currency.sym}"
    else
      "#{number_with_delimiter((tour.price.to_f / @tour_currency.value.to_f * @config.currency.value.to_f).ceil)} #{@config.currency.sym}"
    end
  end

  def show_bel_price(tour)
    @tour_currency = tour.currency
    @bel_rub_currency = Currency.find_by(abbr: 'BYR')
    if @tour_currency == @bel_rub_currency
      "#{number_with_delimiter tour.price } #{@bel_rub_currency.sym}"
    else
      "#{number_with_delimiter((tour.price.to_f * @bel_rub_currency.value.to_f).ceil)} #{@bel_rub_currency.sym}"
    end
  end

  private
    def group_status(color, text)
      content_tag :td, style: "text-align: center; background-color: #{color};width: 135px;" do
        content_tag(:span, style: 'color: #ffffff;font-size: 12.222222328186px; line-height: 21.3333339691162px;') do
          text
        end
      end
    end
end
