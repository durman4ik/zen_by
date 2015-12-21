class Dashboard::PagesController < ApplicationController
  layout 'dashboard', except: :show
  before_action :set_page, only: [:update, :destroy]
  before_action :set_page_by_slug, only: [:show, :edit]

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
    @page.set_meta(page_params)
    if @page.save
      flash[:success] = "Страница '#{@page.title}' успешно создана!"
      redirect_to dashboard_pages_path
    else
      flash[:error] = 'Ошибка! Не удалось создать страницу!'
      render :new, layout: 'dashboard'
    end
  end

  def update
    @page.assign_attributes(page_params)
    @page.set_meta(page_params)
    if @page.save
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
                                   :description_background,
                                   :slug,
                                   templates_attributes: [:_destroy, :id, :name],
                                   sticky_items_attributes:[:_destroy, :title, :id,
                                                            templates_attributes: [:_destroy, :id, :name],
                                                            page_attachments_attributes: [:_destroy, :id, :template],
                                                            html_contents_attributes:[:_destroy, :id, :content]])

    end
end
