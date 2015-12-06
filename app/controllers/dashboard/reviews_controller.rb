class Dashboard::ReviewsController < ApplicationController
  layout 'dashboard', only: [:edit, :new]
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:update, :destroy, :edit, :new]

  def new
    @review = Review.new
  end

  def edit;  end

  def create
    @review = Review.new(review_params)
    @review.set_city_and_ip(request.location)
    respond_to do |format|
      if @review.save
        format.html do
          flash[:success] = 'Отзыв успешно создан!'
          redirect_to dashboard_reviews_path
        end
        format.js { render 'dashboard/reviews/create' }
      else
        format.html do
          flash[:error] = 'Ошибка! Отзыв не был создан!'
          render :new, layout: 'dashboard'
        end
        format.js { render 'dashboard/reviews/create_failed' }
      end
    end
  end

  def update
    @review.image = nil if params[:remove_image].present?
      if @review.update(review_params)
        flash[:success] = 'Отзыв успешно обновлен!'
        redirect_to dashboard_reviews_path page: params[:page]
      else
        flash[:error] = 'Ошибка! Отзыв не был обновлен!'
        render :edit, layout: 'dashboard'
      end
  end

  def destroy
    if @review.destroy
      flash[:success] = 'Отзыв успешно удален'
      redirect_to dashboard_reviews_path page: params[:page]
    else
      flash[:error] = 'Ошибка! Отзыв не был удален!'
      redirect_to dashboard_reviews_path page: params[:page]
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      def_params = [:name, :city, :body, :email, :image, :anti_spam, :ip_address]
      if admin_signed_in?
        def_params << [:status]
        params.require(:review).permit(def_params)
      else
        params.require(:review).permit(def_params)
      end
    end
end
