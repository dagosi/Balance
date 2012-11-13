class RegistersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @registers_years = current_user.registers_years
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
