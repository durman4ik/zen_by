class Dashboard::CountriesController < ApplicationController
  layout 'dashboard',                     only:   [:new, :edit]

  before_action :set_country,             only:   [:update, :destroy]
  before_action :authenticate_admin!,     except: [:show]

  def show
    @country = Country.find_by(slug: params[:slug])
    raise ActionController::RoutingError.new('Not Found') if @country.nil?
  end

  def new
    @country = Country.new
  end

  def edit
    @country = Country.find_by(slug: params[:slug])
    raise ActionController::RoutingError.new('Not Found') if @country.nil?
  end

  def create
    @country = Country.new
    if @country.create_country(country_params)
      flash[:success] = 'Страна успешно создана!'
      redirect_to dashboard_countries_path
    else
      flash[:error] = 'Ошибка! Не удалось создать страну!'
      render :new, layout: 'dashboard'
    end
  end

  def update
    if @country.update_country(country_params)
      flash[:success] = 'Страна успешно обновлена!'
      redirect_to dashboard_countries_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить страну!'
      render :edit, layout: 'dashboard', locals: { flash: flash }
    end
  end

  def destroy
    if @country.destroy
      flash[:success] = 'Страна успешно удалена!'
      redirect_to dashboard_countries_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Страна не была удалена!'
      redirect_to dashboard_countries_path
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      if current_admin
        params.require(:country).permit(:name,
                                        :title,
                                        :description,
                                        :background_color,
                                        :image,
                                        :region,
                                        :remove_image,
                                        :meta_title,
                                        :meta_description,
                                        :slug,
                                        :meta_keywords,
                                        sliders_attributes:             [:id, :_destroy, :title, :image, :description, :type])
      end
    end
end
