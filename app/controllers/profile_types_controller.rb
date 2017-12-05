class ProfileTypesController < ApplicationController
  include SessionsHelper
  before_action :set_profile_type, only: [:show, :edit, :update, :destroy]

  # GET /profile_types
  # GET /profile_types.json
  def index
    only_for_admins
    @profile_types = ProfileType.all
  end

  # GET /profile_types/1
  # GET /profile_types/1.json
  def show
    redirect_to 'index'
  end

  # GET /profile_types/new
  def new
    only_for_admins
    @profile_type = ProfileType.new
  end

  # GET /profile_types/1/edit
  def edit
  end

  # POST /profile_types
  # POST /profile_types.json
  def create
    @profile_type = ProfileType.new(profile_type_params)

    respond_to do |format|
      if @profile_type.save
        format.html { redirect_to @profile_type, notice: 'Profile type was successfully created.' }
        format.json { render :show, status: :created, location: @profile_type }
      else
        format.html { render :new }
        format.json { render json: @profile_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_types/1
  # PATCH/PUT /profile_types/1.json
  def update
    respond_to do |format|
      if @profile_type.update(profile_type_params)
        format.html { redirect_to @profile_type, notice: 'Profile type was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_type }
      else
        format.html { render :edit }
        format.json { render json: @profile_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_types/1
  # DELETE /profile_types/1.json
  def destroy
    @profile_type.destroy
    respond_to do |format|
      format.html { redirect_to profile_types_url, notice: 'Profile type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_type
      if !current_user.is_administrator
        #flash[:error] = 'Only for admins'
        render 'static_pages/home'
      end
      @profile_type = ProfileType.find(params[:id])
      if @profile_type==nil
        flash[:error] = 'Profile type with id ' + params[:id] + ' does not exist.'
        render 'static_pages/home'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_type_params
      params.require(:profile_type).permit(:typeName)
    end

    def only_for_admins
      if !current_user.is_administrator
        flash[:error] = 'Only for admins'
        render 'static_pages/home'
      end
    end
end
