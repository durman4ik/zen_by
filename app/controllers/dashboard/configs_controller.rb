class Dashboard::ConfigsController < ApplicationController
  layout 'dashboard'

  def edit
  end

  def update
    @config.update(admins_params)
    redirect_to edit_dashboard_config_path(@config)
  end

  private

  def admins_params
    params.require(:config).permit(:id, :info_email, :order_email, :phone, :address, :unp,
                                                      :requisites, :map_link, :currency_id, :facebook)
  end
end
