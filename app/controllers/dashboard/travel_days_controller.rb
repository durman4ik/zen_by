class Dashboard::TravelDaysController < ApplicationController

  def create
  end


  def update
  end

  def destroy
  end

  private
  def videos_params
    params.require(:travel_day).permit(:title, :day_number, :description, :_destroy,
                                       travel_day_images_attributes: [:id, :_destroy, :uploaded_file])
  end

end
