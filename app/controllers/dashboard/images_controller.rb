class Dashboard::ImagesController < ApplicationController
  def create

  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
  end

  private
  def images_params
    params.require(:image).permit(:file, :files, :public_id)
  end
end
