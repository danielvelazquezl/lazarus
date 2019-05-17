class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
     @roles = Role.all_role
  end
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_path }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    #@users_roles = UsersRoles.where(role_id: @role.id)
    #@users_roles.each do |ur|
     # ur.destroy
    #end
    @permission = Permission.where(role_id: @role.id)
    @permission.each do |p|
      p.destroy
    end
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_path}
      format.json { head :no_content }
    end
  end

  def user
    @user = User.find(params[:id])
    @users_roles = UsersRole.where(user_id: params[:id])
    @roles = []
    @users_roles.each do |us|
      @roles.push(Role.find(us.role_id))
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:name)
  end
end
