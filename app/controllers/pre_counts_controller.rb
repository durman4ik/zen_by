class PreCountsController < ApplicationController
  def create
    @pre_count = PreCount.new(pre_count_params)
    if @pre_count.save
      AdminMailer.new_pre_count(@pre_count).deliver_now
    end
  end

  protected

  def pre_count_params
    params.require(:pre_count).permit(
        :name,
        :phone,
        :email,
        :country,
        :date,
        :days,
        :group,
        :message,
        :hotel,
        :anti_spam
    )
  end
end
