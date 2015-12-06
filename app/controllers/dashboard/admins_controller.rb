class Dashboard::AdminsController < ApplicationController
  layout 'dashboard'
  before_action :set_admin, only: [:edit, :update]

  def create
    @admin = Admin.create(login: 'admin', password: '12345678')
  end

  def edit
  end

  def update
    @admin.update(admins_params)
    redirect_to edit_dashboard_admin_path(current_admin)
  end

  private

    def admins_params
      params.require(:admin).permit(:name)
    end

  def set_admin
      @admin = current_admin
    end

end
