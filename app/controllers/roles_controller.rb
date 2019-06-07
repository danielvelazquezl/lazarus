class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
     @roles = Role.all_role

  end
  def new
    @role = Role.new
    @permission = @role.permissions.build
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

  def edit
  end

  def update
    respond_to do |format|
      if @role.update_attributes(role_params)
        format.html {redirect_to roles_path, notice: 'Role actualizado.'}
      else

        format.html { render :edit }
        format.json { render json: @role.errors, note: :unprocessable_entity }
      end
    end
  end

  def destroy

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
    params.require(:role).permit(:name, permissions_attributes: [:id, :resource_id, :action_create, :action_read, :action_update, :action_destroy])
  end
end
