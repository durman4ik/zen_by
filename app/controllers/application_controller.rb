class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_data
  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_data
    @config = Config.first_or_create
    @categories = Category.all
    @pages = Page.with_position
    @countries = Country.sorted_by_name
    @reviews = Review.approved
    @menu_items = MenuItem.order_by(position: :asc)
  end

  def check_page(page, total_pages)
    page.to_i > total_pages.to_i ? total_pages : page
  end


end
