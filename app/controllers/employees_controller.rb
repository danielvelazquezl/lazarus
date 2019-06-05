class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :destroy]
  def index
    (@filterrific = initialize_filterrific(
        Employee,
        params[:filterrific],
        select_options: {
            sorted_by: Employee.options_for_sorted_by
        },
        )) || return
    @employee = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @employee = Employee.new
    @employee.birth_date = Time.now
  end

  def create
    @person = Person.new(person_params)
    @user = User.new(user_name: @person.name, email: @person.email, password: '123456', password_confirmation: '123456')
    if @person.save and @user.save
      @employee = Employee.new(employee_params)

      @employee.person_id = @person.id
      @employee.user_id = @user.id

      respond_to do |format|
        if @employee.save
          format.html { redirect_to @employee, notice: 'Funcionario guardado' }
        else
          format.html { render :new, notice: 'No se pudo guardar el nuevo funcionario' }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, notice: 'No se pudo guardar el nuevo funcionario' }
      end
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_path }
      format.js { render :layout => false }
    end
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:ci, :sex, :birth_date, :charge)
    end

  def person_params
    params.require(:person).permit(:name, :address, :phone, :email)
  end

end
