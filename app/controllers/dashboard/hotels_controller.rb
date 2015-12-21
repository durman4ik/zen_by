class Dashboard::HotelsController < ApplicationController
 layout 'dashboard'
 before_action :set_hotel, only: [:edit, :update, :destroy]
 before_action :authenticate_admin!

  def new
    @hotel = Hotel.new
  end

  def edit
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      @hotel.add_images_to_gallery(hotel_params)
      flash[:success] = 'Отель успешно создан!'
      redirect_to dashboard_hotels_path
    else
      flash[:error] = 'Ошибка! Не удалось создать отель!'
      render :new, layout: 'dashboard'
    end
  end


  def update
    if @hotel.update_hotel(hotel_params)
      flash[:success] = 'Отель успешно обновлен!'
      redirect_to dashboard_hotels_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить отель!'
      render :edit, layout: 'dashboard'
    end

  end

  def destroy
    if @hotel.destroy
      flash[:success] = 'Отель успешно удален!'
      redirect_to dashboard_hotels_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Не удалось удалить отель!'
      redirect_to dashboard_hotels_path
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:title, :stars, :country_id, :description, hotel_images:[])
  end
end
