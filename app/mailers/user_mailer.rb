class UserMailer < ApplicationMailer
  default from: 'notification@zen.by'

  def inform_user(order)
    @order = order
    @url = 'http://zen.by/'
    if @order.email.present?
      mail(to: @order.email, subject: 'Бронирование тура - Искатели впечатлений!')
    else
      false
    end
  end

  def subscribe_user(subscription)
    @subscription = subscription
    @url = 'http://zen.by/'

    if @subscription.email.present?
      mail(to: @subscription.email, subject: 'Оформление подписки - Искатели впечатлений!')
    else
      false
    end
  end
end
