class Dashboard::AboutPageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @about_page = AboutPage.first_or_create
    @reviews = Review.approved
  end

  def create
    AboutPage.create(about_page_params)
  end

  def edit
    @about_page = AboutPage.first_or_create
  end

  def update
    @about_page = AboutPage.first
    @about_page.set_meta(about_page_params)
    respond_to do |format|
      if @about_page.update(about_page_params)
        format.html { redirect_to edit_dashboard_about_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def about_page_params
    params.require(:about_page).permit(:title, :description, :slug, :meta_description,
                                       :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
  end

end
