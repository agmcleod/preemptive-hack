class HackdayOrganizationsController < ApplicationController
  before_action :set_hackday_organization, only: [:show, :edit, :update, :destroy]

  # GET /hackday_organizations
  # GET /hackday_organizations.json
  def index
    @hackday_organizations = HackdayOrganization.all
  end

  # GET /hackday_organizations/1
  # GET /hackday_organizations/1.json
  def show
  end

  # GET /hackday_organizations/new
  def new
    @hackday_organization = HackdayOrganization.new
  end

  # GET /hackday_organizations/1/edit
  def edit
  end

  # POST /hackday_organizations
  # POST /hackday_organizations.json
  def create
    @hackday_organization = HackdayOrganization.new(hackday_organization_params)

    respond_to do |format|
      if @hackday_organization.save
        format.html { redirect_to @hackday_organization, notice: 'Hackday organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hackday_organization }
      else
        format.html { render 'new' }
        format.json { render json: @hackday_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hackday_organizations/1
  # PATCH/PUT /hackday_organizations/1.json
  def update
    respond_to do |format|
      if @hackday_organization.update(hackday_organization_params)
        format.html { redirect_to @hackday_organization, notice: 'Hackday organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @hackday_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hackday_organizations/1
  # DELETE /hackday_organizations/1.json
  def destroy
    @hackday_organization.destroy
    respond_to do |format|
      format.html { redirect_to hackday_organizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hackday_organization
      @hackday_organization = HackdayOrganization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hackday_organization_params
      params.require(:hackday_organization).permit(:name)
    end
end
