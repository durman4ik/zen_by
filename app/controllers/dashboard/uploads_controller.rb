class Dashboard::UploadsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @upload = Upload.create(upload_params)
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
  end

  private
  def upload_params
    params.require(:upload).permit(:file)
  end

end
