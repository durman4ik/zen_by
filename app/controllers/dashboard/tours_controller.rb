class Dashboard::ToursController < ApplicationController
  layout 'dashboard', except: [:show]

  before_action :set_tour, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show]

  def index
    @tours = Tour.all
  end

  def show
    @tour = Tour.find_by(slug: params[:slug])
    raise ActionController::RoutingError.new('Not Found') if @tour.nil?
    @travel_days = @tour.travel_days.sort { |a, b| a.day_number.to_i <=> b.day_number.to_i }
    @order = Order.new
  end

  def new
    @tour = Tour.new
  end

  def edit
  end

  def create
    @tour = Tour.new
    if @tour.create_tour(tour_params)
      @tour.add_images_to_tour_gallery(tour_params)
      flash[:success] = 'Тур успешно создан!'
      redirect_to dashboard_tours_path
    else
      flash[:error] = 'Ошибка! Не удалось создать тур'
      render :new, layout: 'dashboard'
    end
  end

  def update
    if @tour.update_tour(tour_params)
      flash[:success] = 'Тур успешно обновлен!'
      redirect_to dashboard_tours_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить тур!'
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = 'Тур успешно удален!'
      redirect_to dashboard_tours_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Тур не был удален!'
      redirect_to dashboard_tours_path
    end
  end

  private

    def set_tour
      @tour = Tour.find(params[:id])
    end

    def tour_params
      params.require(:tour).permit(
          :name,
          :image,
          :city,
          :route,
          :map_link,
          :description,
          :details,
          :price,
          :price_description,
          :days,
          :days_remark,
          :hotels_remark,
          :group_tour,
          :show_hotels_with_date,
          :use_in_slider,
          :meta_title,
          :meta_description,
          :meta_keywords,
          :slug,
          :country_id,
          :currency_id,
          :remove_image,
          category_ids:                   [],
          gallery_images:                 [],
          price_includes_attributes:      [:id, :_destroy, :title],
          price_not_includes_attributes:  [:id, :_destroy, :title],
          videos_attributes:              [:id, :video_id, :_destroy],
          days_in_hotels_attributes:      [:id, :hotel_id, :days, :_destroy],
          faqs_attributes:                [:id, :_destroy, :title, :description],
          sliders_attributes:             [:id, :_destroy, :title, :image, :description],
          departures_attributes:          [:id, :from, :_destroy,
                                          travel_groups_attributes: [:id, :start_date, :finish_date, :active, :_destroy]],
          travel_days_attributes:         [:id, :day_number, :title, :description, :_destroy,
                                                              images_attributes:[:id, :_destroy, :uploaded_file]] )
    end
end
