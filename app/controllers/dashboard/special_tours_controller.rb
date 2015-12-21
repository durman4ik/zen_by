class Dashboard::SpecialToursController < ApplicationController
  layout 'dashboard'
  before_action :set_special_tour, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!

  def new
    @special_tour = SpecialTour.new
    @special_tour.build_calendar
  end

  def edit
    @special_tour.build_calendar unless @special_tour.calendar
  end

  def create
    @special_tour = SpecialTour.new(special_tour_params)
    if @special_tour.save
      flash[:success] = 'Тур успешно создан!'
      redirect_to dashboard_special_tours_path
    else
      flash[:error] = 'Ошибка! Тур не был создан!'
      render :edit, layout: 'dashboard'
    end
  end

  def update
    if @special_tour.update_tour(special_tour_params)
      flash[:success] = 'Тур успешно обновлен!'
      redirect_to dashboard_special_tours_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Тур обновлен не был'
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @special_tour.destroy
      flash[:success] = 'Тур успешно удален!'
      redirect_to dashboard_special_tours_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Тур не был удален!'
      redirect_to dashboard_special_tours_path page: params[:page]
    end
  end

  private

  def set_special_tour
    @special_tour = SpecialTour.find(params[:id])
  end

  def special_tour_params
    params.require(:special_tour).permit(:name,
                                         :region,
                                         :city,
                                         :route,
                                         :description,
                                         :price,
                                         :group_size,
                                         :tour_type,
                                         :days,
                                         :remove_image,
                                         :country,
                                         :region,
                                         :currency_id,
                                         :image,
                                         calendar_attributes:    [:jan, :feb, :mar, :apr, :may, :jun, :jul, :aug,
                                                                  :sep, :oct, :nov, :dec],
                                         travel_tasks_attributes:[:id, :_destroy, :title,
                                                                  task_items_attributes:[:id, :_destroy, :title]])
  end


end


