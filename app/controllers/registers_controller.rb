class RegistersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @registers_dates_years = Register.registers_dates_by_years
    @registers_dates_months = Register.registers_dates_by_months
    @registers_by_date = lambda do |year, month|
      current_user.registers_by_date(year, month)
    end
  end

  def show
    @register = current_user.registers.find(params[:id])
  end

  def new
    @register = current_user.registers.build
  end

  def edit
    @register = current_user.registers.find(params[:id])
  end

  def create
    @register = current_user.registers.build(params[:register])

    if @register.save
      redirect_to @register, notice: 'Register was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @register = current_user.registers.find(params[:id])

    if @register.update_attributes(params[:register])
      redirect_to @register, notice: 'Register was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @register = current_user.registers.find(params[:id])
    @register.destroy

    redirect_to registers_url
  end
end
