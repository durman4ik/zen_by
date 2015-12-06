class Dashboard::CountryPageController < ApplicationController

  def index
    @country_page = CountryPage.first
    @countries = Country.sorted_by_name.all
  end

  def create
    CountryPage.create(country_page_params)
  end

  def update
    @country_page = CountryPage.first
    @country_page.set_meta(country_page_params)
    respond_to do |format|
      if @country_page.update(country_page_params)
        format.html { redirect_to dashboard_countries_page_path }
      else
        format.html { render dashboard_countries_page_path }
      end
    end
  end

  private
    def country_page_params
      params.require(:country_page).permit(:title, :description, :slug, :meta_description, :meta_title, :meta_keywords)
    end

end
