class Dashboard::MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:edit, :destroy, :update]
  layout 'dashboard'

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      flash[:success] = 'Пункт меню успешно создан!'
      redirect_to dashboard_menus_path
    else
      flash[:error] = 'Ошибка! Не удалось создать пункт меню!'
      render :new, layout: 'dashboard'
    end
  end

  def edit
  end

  def update
    if @menu_item.update(menu_item_params)
      flash[:success] = 'Пункт меню успешно обновлен!'
      redirect_to dashboard_menus_path
    else
      flash[:error] = 'Ошибка! Не удалось обновить пункт меню!'
      render :edit, layout: 'dashboard'
    end
  end

  def destroy
    if @menu_item.destroy
      flash[:success] = 'Пункт меню успешно удален!'
      redirect_to dashboard_menus_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Не удалось удалить пункт меню!'
      redirect_to dashboard_menus_path page: params[:page]
    end
  end

  private
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    def menu_item_params
      params.require(:menu_item).permit(:name,
                                        :position,
                                        :external_link,
                                        :attachment_type,
                                        :stick_to_menu,
                                        :page_id,
                                        :tour_id,
                                        :country_id,
                                        :category_id,
                                        sub_menu_items_attributes: [:id, :_destroy, :attachment_type, :external_link,
                                                                    :name, :page_id,:tour_id, :country_id, :category_id, :position])
    end
end
