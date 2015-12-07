class HomePagesController < ApplicationController
  layout 'dashboard', except: [:index, :subscribe]
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @sliders = Slider.all
    @main_categories = Category.showed_on_main
  end

  def edit
  end

  def update
    if @home_page.update_page(home_page_params)
      flash[:success] = 'Главная странаница успешно обновлена!'
      redirect_to dashboard_pages_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Не удалось обновить глваную страницу!'
      render :edit, layout: 'dashboard'
    end
  end

  def subscribe
  end

  private
    def home_page_params
      params.require(:home_page).permit(:title_on_main,
                                        :show_title,
                                        :description,
                                        :description_background,
                                        :slider_enabled,
                                        :remove_image,

                                        :left_side_title,
                                        :left_side_text,
                                        :left_side_link,

                                        :meta_title,
                                        :meta_description,
                                        :meta_keywords            )
    end
end
