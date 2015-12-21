class Dashboard::AboutsController < ApplicationController
  layout 'dashboard'

  def update
    if @about.update_about(about_params)
      flash[:success] = 'Информация о компании успешно обновлена!'
      redirect_to dashboard_path
    else
      flash[:error] = 'Ошибка! Информация о компании не была обновлена'
      render :edit, layout: 'dashboard'
    end
  end

  def edit
  end

  private

    def about_params

      params.require(:about).permit(:info_email,
                                    :order_email,
                                    :subscribe_email,
                                    :phone,
                                    :address,
                                    :unp,
                                    :requisites,
                                    :map_link,
                                    :facebook,
                                    why_us_causes_attributes:[:id, :_destroy, :title, :description, :image,
                                                              :remove_image])
    end
end
