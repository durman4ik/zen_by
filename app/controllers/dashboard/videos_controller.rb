class Dashboard::VideosController < ApplicationController

  def create
    @video = Video.create(videos_params)
  end


  def update
  end

  def destroy
  end

  private
    def videos_params
      params.require(:video).permit(:video_id)
    end

end
