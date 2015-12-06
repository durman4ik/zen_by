class Dashboard::FindTourPageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @find_tour_page = FindTourPage.first_or_create
  end

  def create
    FindTourPage.create(find_tour_page_params)
  end

  def edit
    @find_tour_page = FindTourPage.first_or_create
  end

  def update
    @find_tour_page = FindTourPage.first
    @find_tour_page.set_meta(find_tour_page_params)
    respond_to do |format|
      if @find_tour_page.update(find_tour_page_params)
        format.html { redirect_to edit_dashboard_find_tour_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def find_tour_page_params
      params.require(:find_tour_page).permit(:title, :description, :slug, :meta_description,
                                             :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
    end

end


