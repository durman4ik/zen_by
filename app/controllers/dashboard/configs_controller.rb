class Dashboard::ConfigsController < ApplicationController
  layout 'dashboard'

  def edit
  end

  def update
    if @config.update_config(config_params)
      flash[:success] = 'Настройки сайта успешно обновлены!'
      redirect_to dashboard_path
    else
      flash[:error] = 'Ошибка! Настройки сайта не были обновлены!'
      render :edit, layout: 'dashboard'
    end
  end

  private

  def config_params
    params.require(:config).permit(:currency_id,
                                   :slider_enabled,
                                   :facebook_enabled,
                                   :subscribe_enabled,
                                   :remove_image,
                                   :logo)
  end
end
