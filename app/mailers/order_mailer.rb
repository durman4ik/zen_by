class OrderMailer < ApplicationMailer
  default from: 'new_order@zen.by'

  def new_order(order)
    @order = order
    @url = 'http://zen.by/dashboard/'
    email = Config.first.order_email
    if email.present?
      mail(to: email, subject: 'Новый заказ с сайта zen.by')
    end
  end
end
