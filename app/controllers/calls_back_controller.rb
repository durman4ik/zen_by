class CallsBackController < ApplicationController

  def create
    @callback = CallsBack.new(callback_params)
    if @callback.save
      AdminMailer.new_callback(@callback).deliver_now
      respond_to do |format|
        format.js { render 'calls_back/create'}
      end
    else
      respond_to do |format|
        format.js { render 'calls_back/create_failed'}
      end
    end
  end

  protected
    def callback_params
      params.require(:calls_back).permit(:name, :phone, :anti_spam, :message)
    end
end
