class UserToSkillsController < ApplicationController
  before_action :set_user_to_skill, only: [:show, :edit, :update, :destroy]

  # # GET /user_to_skills
  # # GET /user_to_skills.json
  # def index
  #   @user_to_skills = UserToSkill.all
  # end
  #
  # # GET /user_to_skills/1
  # # GET /user_to_skills/1.json
  # def show
  # end
  #
  # # GET /user_to_skills/new
  # def new
  #   @user_to_skill = UserToSkill.new
  # end
  #
  # # GET /user_to_skills/1/edit
  # def edit
  # end

  # POST /user_to_skills
  # POST /user_to_skills.json
  def create
    @user_to_skill = UserToSkill.new(user_to_skill_params)
    return unless check_permission
    respond_to do |format|
      if @user_to_skill.save
        format.html { redirect_to @user_to_skill, notice: 'User to skill was successfully created.' }
        format.json { render :show, status: :created, location: @user_to_skill }
      else
        format.html { render :new }
        format.json { render json: @user_to_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /user_to_skills/1
  # # PATCH/PUT /user_to_skills/1.json
  # def update
  #   respond_to do |format|
  #     if @user_to_skill.update(user_to_skill_params)
  #       format.html { redirect_to @user_to_skill, notice: 'User to skill was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user_to_skill }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user_to_skill.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /user_to_skills/1
  # DELETE /user_to_skills/1.json
  def destroy
    return unless check_permission
    @user_to_skill.destroy
    respond_to do |format|
      format.html { redirect_to user_to_skills_url, notice: 'User to skill was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
  def check_permission
    @user_is_owner_of_association = has_user_permission? @user_to_skill
    redirect_to root_url, notice: 'Wrong Permissions' unless @user_is_owner_of_association
    return false unless @user_is_owner_of_association
    true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_to_skill
    @user_to_skill = UserToSkill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_to_skill_params
    params.require(:user_to_skill).permit(:user_id, :skill_id)
  end
end