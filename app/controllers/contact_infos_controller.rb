class ContactInfosController < ApplicationController
  before_action :set_contact_info, only: [:show, :edit, :update, :destroy]

  # GET /contact_infos
  # GET /contact_infos.json
  def index
    @contact_infos = ContactInfo.all
  end

  # GET /contact_infos/1
  # GET /contact_infos/1.json
  def show
  end

  # GET /contact_infos/new
  def new
    @contact_info = ContactInfo.new
  end

  # GET /contact_infos/1/edit
  def edit
  end

  # POST /contact_infos
  # POST /contact_infos.json
  def create
    @contact_info = ContactInfo.new(contact_info_params)

    respond_to do |format|
      if @contact_info.save
        format.html { redirect_to @contact_info, notice: 'Contact info was successfully created.' }
        format.json { render :show, status: :created, location: @contact_info }
      else
        format.html { render :new }
        format.json { render json: @contact_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_infos/1
  # PATCH/PUT /contact_infos/1.json
  def update
    respond_to do |format|
      if @contact_info.update(contact_info_params)
        format.html { redirect_to @contact_info, notice: 'Contact info was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact_info }
      else
        format.html { render :edit }
        format.json { render json: @contact_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_infos/1
  # DELETE /contact_infos/1.json
  def destroy
    @contact_info.destroy
    respond_to do |format|
      format.html { redirect_to contact_infos_url, notice: 'Contact info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_info
      @contact_info = ContactInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_info_params
      params[:contact_info]
    end
end
