class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_admin!
  skip_before_action :verify_authenticy_token, only: [:reviews]

  def index
  end

  def currencies
    @currencies = Currency.all.order_by(value: :desc)
  end

  def pages
    query = Page.all.order_by(menu_name: :asc)
    total_pages = get_pages(query, 15)
    @pages = get_objects(query, 15, total_pages)
    check_redirect(total_pages)
  end

  def menus
    query = MenuItem.order_by(position: :asc)
    total_pages = get_pages(query, 10)
    @menu_items = get_objects(query, 10, total_pages)
    check_redirect(total_pages)
  end

  def countries
    query = Country.all.order_by(name: :desc)
    total_pages = get_pages(query, 12)
    @countries = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def reviews
    query = Review.all.order_by(created_at: :desc)
    total_pages = get_pages(query, 12)
    @reviews = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def tours
    query = Tour.all.order_by(created_at: :desc)
    total_pages = get_pages(query, 12)
    @tours = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def hotels
    query = Hotel.all.order_by(stars: :desc)
    total_pages = get_pages(query, 12)
    @hotels = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def categories
    query = Category.all
    total_pages = get_pages(query, 12)
    @categories = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def orders
    query = Order.all.order_by(created_at: :desc)
    total_pages = get_pages(query, 12)
    @orders = get_objects(query, 12, total_pages)
    check_redirect(total_pages)
  end

  def get_pages(query, per)
    query.page(params[:page]).per(per).total_pages
  end

  def get_objects(query, per, total_pages)
    query.page(check_page(params[:page], total_pages)).per(per)
  end

  def check_redirect(total_pages)
    if params[:page].to_i > total_pages.to_i
      redirect_to controller: 'dashboard', action: params[:action],  page: check_page(params[:page], total_pages)
    end
  end
end
