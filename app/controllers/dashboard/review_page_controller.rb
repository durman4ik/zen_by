class Dashboard::ReviewPageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @review_page = ReviewPage.first_or_create
    @reviews = Review.approved
  end

  def create
    ReviewPage.create(review_page_params)
  end

  def edit
    @review_page = ReviewPage.first_or_create
  end

  def update
    @review_page = ReviewPage.first
    @review_page.set_meta(review_page_params)
    respond_to do |format|
      if @review_page.update(review_page_params)
        format.html { redirect_to edit_dashboard_review_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def review_page_params
      params.require(:review_page).permit(:title, :description, :slug, :meta_description,
                                          :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
    end

end
