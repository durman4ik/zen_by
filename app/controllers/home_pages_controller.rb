class HomePagesController < ApplicationController
  layout 'dashboard', except: [:index]
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @sliders = Slider.all
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

  def robots
    @tours = Tour.all
    @pages = Page.all.includes(:menu_item, :sub_menu_item).find_all {|x| x.sub_menu_item != nil || x.menu_item != nil}
    redirect_to 'home_pages/robots', format: :text
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
                                        :meta_keywords,
                                        sliders_attributes:      [:id, :_destroy, :title, :description, :image, :type,
                                                                  :country_id, :tour_id, :category_id],
                                        faqs_attributes:         [:id, :_destroy, :title, :description],
                                        sticky_items_attributes: [:id, :_destroy, :title, :full_title, :link,
                                                                  page_attachments_attributes: [:type, :id, :_destroy, :tour_id,
                                                                                                :country_id, :page_id, :category_id],
                                                                  templates_attributes:[:id, :_destroy, :name]] )
    end
end
