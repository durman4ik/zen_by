class Dashboard::CategoriesController < ApplicationController
  layout 'dashboard', only: [:new, :edit]

  before_action :set_category,          only:   [:update, :destroy]
  before_action :authenticate_admin!,   except: [:show]

  def show
    @category = Category.find_by(slug: params[:slug])
    raise ActionController::RoutingError.new('Not Found') if @category.nil?
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by(slug: params[:slug])
    raise ActionController::RoutingError.new('Not Found') if @category.nil?
  end

  def create
    @category = Category.new
    if @category.create_category(category_params)
      flash[:success] = 'Категория успешно создана!'
      redirect_to dashboard_categories_path
    else
      flash[:error] = 'Ошибка! Не удалось создать категорию!'
      render :new, layout: 'dashboard'
    end
  end

  def update
    if @category.update_category(category_params)
      flash[:success] = 'Категория успешно обновлена!'
      redirect_to dashboard_categories_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить категорию!'
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Категория успешно удалена!'
      redirect_to dashboard_categories_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Категория не была удалена'
      redirect_to dashboard_categories_path
    end
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    if current_admin
      params.require(:category).permit(:name,
                                       :title,
                                       :description,
                                       :background_color,
                                       :image,
                                       :meta_title,
                                       :meta_description,
                                       :slug,
                                       :meta_keywords,
                                       :remove_image,
                                       sliders_attributes:[:id, :_destroy, :title, :image, :description, :type])
    end
  end
end
