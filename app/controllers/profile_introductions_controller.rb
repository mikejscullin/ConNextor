
class ProfileIntroductionsController < ApplicationController
  before_action :set_profile_introduction, only: [:show, :swap, :edit, :update, :destroy]

  # GET /profile_introductions
  # GET /profile_introductions.json
  def index
    @profile_introductions = ProfileIntroduction.all
  end

  # GET /profile_introductions/1
  # GET /profile_introductions/1.json
  def show
  end

  # GET /profile_introductions/new
  def new
    @profile_introduction = ProfileIntroduction.new
  end

  # GET /profile_introductions/1/edit
  def edit
  end

  # AJAX purposes only.
  # GET /profile_introduction/swap/1
  def swap
    respond_to do |format|
      format.js
    end
  end

  # POST /profile_introductions
  # POST /profile_introductions.json
  def create
    @profile_introduction = ProfileIntroduction.new(profile_introduction_params)
    @profile = @profile_introduction.profile
    @user_is_owner_of_profile = @profile == current_user.profile
    respond_to do |format|
      if @profile_introduction.save
        format.html { redirect_to @profile_introduction, notice: 'Profile introduction was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @profile_introduction }
      else
        format.html { render :new }
        format.json { render json: @profile_introduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_introductions/1
  # PATCH/PUT /profile_introductions/1.json
  def update
    @profile = @profile_introduction.profile
    @user_is_owner_of_profile = @profile == current_user.profile
    respond_to do |format|
      if @profile_introduction.update(profile_introduction_params)
        format.html { redirect_to @profile_introduction, notice: 'Profile introduction was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @profile_introduction }
      else
        format.html { render :edit }
        format.json { render json: @profile_introduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_introductions/1
  # DELETE /profile_introductions/1.json
  def destroy
    @profile_introduction.destroy
    respond_to do |format|
      format.html { redirect_to profile_introductions_url, notice: 'Profile introduction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_introduction
      @profile_introduction = ProfileIntroduction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_introduction_params
      params.require(:profile_introduction).permit(:profile_id, :body)
    end
end