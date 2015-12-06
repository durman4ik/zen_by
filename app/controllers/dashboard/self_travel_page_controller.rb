class Dashboard::SelfTravelPageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @self_travel_page = SelfTravelPage.first_or_create
  end

  def create
    SelfTravelPage.create(self_travel_page_params)
  end

  def edit
    @self_travel_page = SelfTravelPage.first_or_create
  end

  def update
    @self_travel_page = SelfTravelPage.first
    @self_travel_page.set_meta(self_travel_page_params)
    respond_to do |format|
      if @self_travel_page.update(self_travel_page_params)
        format.html { redirect_to edit_dashboard_self_travel_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def self_travel_page_params
      params.require(:self_travel_page).permit(:title, :description, :slug, :meta_description,
                                             :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
    end

end


