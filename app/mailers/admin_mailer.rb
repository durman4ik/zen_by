class AdminMailer < ApplicationMailer
  default from: 'new_order@zen.by'
  before_action :set_url

  def new_order(order)
    @order = order
    email = About.first.order_email
    if email.present?
      mail(to: email, subject: 'Новый заказ с сайта zen.by')
    end
  end

  def new_subscription(subscription)
    @subscription = subscription
    email = About.first.subscribe_email
    if email.present?
      mail(to: email, subject: 'Новая подписка с сайта zen.by')
    end
  end

  def new_callback(callback)
    @calls_back = callback
    email = About.first.order_email
    if email.present?
      mail(to: email, subject: 'Просьба перезвонить с сайта zen.by')
    end
  end

  def new_pre_count(pre_count)
    @pre_count = pre_count
    email = About.first.order_email
    if email.present?
      mail(to: email, subject: 'Новая заявка на рассчет стоимости с сайта zen.by')
    end
  end

  private

    def set_url
      @url = 'http://zen.by/dashboard/'
    end
end
