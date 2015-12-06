class Dashboard::TravelDayImagesController < ApplicationController
  before_action :authenticate_admin!

  def create
    @travel_day_image = TravelDayImage.create(travel_day_images_params)
  end

  def destroy
    @travel_day_image = TravelDayImage.find(params[:id])
    @travel_day_image.destroy
  end

  private
  def travel_day_images_params
    params.require(:travel_day_image).permit!
  end

end
