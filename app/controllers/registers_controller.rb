# -*- coding: utf-8 -*-
class RegistersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @registers_years = current_user.registers_years
  end

  def new
    @register = current_user.registers.build
    @categories = current_user.categories
    puts "adsf asdfklaj slkdjfjalksñjdfl" , @categories
  end

  def edit
    @register = current_user.registers.find(params[:id])
    @categories = current_user.categories
  end

  def create
    @register = current_user.registers.build(params[:register])
    if @register.save
      redirect_to registers_url, notice: 'Register was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @register = current_user.registers.find(params[:id])
    if @register.update_attributes(params[:register])
      redirect_to registers_url, notice: 'Register was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @register = current_user.registers.find(params[:id])
    @register.destroy

    redirect_to registers_url
  end

  def destroy_month
    @year = params[:year]
    @month = params[:month]
    @registers = current_user.registers_by_date(@year, @month)
    @registers.delete_all

    redirect_to registers_url
  end

  def destroy_year
    @year = params[:year]
    @registers = current_user.registers_by_year(@year)
    @registers.delete_all

    redirect_to registers_url
  end
end
