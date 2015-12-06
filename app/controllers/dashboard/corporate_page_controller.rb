class Dashboard::CorporatePageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @corporate_page = CorporatePage.first_or_create
  end

  def create
    CorporatePage.create(corporate_page_params)
  end

  def edit
    @corporate_page = CorporatePage.first_or_create
  end

  def update
    @corporate_page = CorporatePage.first
    @corporate_page.set_meta(corporate_page_params)
    respond_to do |format|
      if @corporate_page.update(corporate_page_params)
        format.html { redirect_to edit_dashboard_corporate_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def corporate_page_params
    params.require(:corporate_page).permit(:title, :description, :slug, :meta_description,
                                          :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
  end

end

