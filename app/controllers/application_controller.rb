class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_data
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

    def layout_by_resource
      if devise_controller?
        'login'
      else
        'application'
      end
    end

    def set_data
      @home_page  = HomePage.first_or_create
      @config     = Config.first_or_create
      @about      = About.first_or_create
      @categories = Category.all
      @countries  = Country.sorted_by_name
      @menu_items = MenuItem.order_by(position: :asc)
    end

    def check_page(page, total_pages)
      page.to_i > total_pages.to_i ? total_pages : page
    end

    def check_redirect(total_pages)
      if params[:page].to_i > total_pages.to_i
        redirect_to controller: 'dashboard', action: params[:action],  page: check_page(params[:page], total_pages)
      end
    end
end
