class Dashboard::OrdersController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_admin!, except: [:create]
  before_action :set_order, only: [:update, :destroy]

  def new
    @order = Order.new
  end

  def update
    @order.update(order_params)
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        AdminMailer.new_order(@order).deliver_now
        UserMailer.inform_user(@order).deliver_now
        format.html do
          if current_admin
            flash[:success] = 'Заказ успешно создан!'
            redirect_to dashboard_orders_path
          else
            render nothing: true
          end
        end
        format.js do
          render 'dashboard/reviews/create'
        end
      else
        format.html do
          if current_admin
            flash[:error] = 'Ошибка! Не удалось создать заказ!'
            render :new
          else
            render nothing: true
          end
        end
        format.js
      end
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = 'Заказ успешно удален!'
      redirect_to dashboard_orders_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Заказ не был удален!'
      redirect_to dashboard_orders_path
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :email, :phone, :city, :message, :tour_id, :anti_spam, :status)
    end
end
