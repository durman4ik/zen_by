class Dashboard::PagesController < ApplicationController
  before_action :set_page, only: [:update, :destroy]
  before_action :set_page_by_slug, only: [:show, :edit]
  before_action :set_collection_for_select, only: [:new, :edit]
  layout 'dashboard', except: :show

  def index
    @pages = Page.with_position.all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = "Страница '#{@page.title}' успешно создана!"
      redirect_to dashboard_pages_path
    else
      flash[:error] = 'Ошибка! Не удалось создать страницу!'
      render :new, layout: 'dashboard'
    end
  end

  def update
    if @page.update(page_params)
      flash[:success] = 'Страница успешно обновлена!'
      redirect_to dashboard_pages_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить страницу!'
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @page.destroy
      flash[:success] = 'Страница успешно удалена!'
      redirect_to dashboard_pages_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Страница не была удалена!'
      redirect_to dashboard_pages_path
    end
  end

  private

    def set_collection_for_select
      @pages_for_select = Page.all.or({parent: nil}, {parent: ''})
    end

    def set_page
      @page = Page.find(params[:id])
    end

    def set_page_by_slug
      @page = Page.find_by(slug: params[:slug])
      raise ActionController::RoutingError.new('Not Found') if @page.nil?
    end

    def page_params
      params.require(:page).permit(:title,
                                   :show_title,
                                   :description,
                                   :html_content,
                                   :stick_to_body,
                                   :meta_title,
                                   :meta_description,
                                   :meta_keywords,
                                   :parent,
                                   :menu_position,
                                   :description_background,
                                   :enabled,
                                   :slug                     )

    end
end
