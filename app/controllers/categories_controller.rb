class CategoriesController < ApplicationController

  def index
    @categories = current_user.categories.all
  end


  def new
    @category = current_user.categories.build
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def create
    @category = current_user.categories.build(params[:category])

    if @category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @category = current_user.categories.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to categories_url, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy

    redirect_to categories_url
  end
end
