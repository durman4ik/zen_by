class Dashboard::ContactsPageController < ApplicationController
  layout 'dashboard', only: :edit
  before_action :authenticate_admin!, only: [:edit, :update]

  def index
    @contacts_page = ContactsPage.first_or_create
  end

  def create
    ContactsPage.create(contacts_page_params)
  end

  def edit
    @contacts_page = ContactsPage.first_or_create
  end

  def update
    @contacts_page = ContactsPage.first
    @contacts_page.set_meta(contacts_page_params)
    respond_to do |format|
      if @contacts_page.update(contacts_page_params)
        format.html { redirect_to edit_dashboard_contacts_page_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def contacts_page_params
      params.require(:contacts_page).permit(:title, :description, :slug, :meta_description,
                                          :meta_title, :meta_keywords, :enabled, :font_color, :description_background)
    end

end
