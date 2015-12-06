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
end
