class DosesController < ApplicationController
  before_action :find_cocktail, only: [:create, :new]

  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to edit_user_cocktail_path(current_user, @cocktail)
    else
      redirect_to edit_user_cocktail_path(current_user, @cocktail)
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to edit_user_cocktail_path(current_user, @cocktail)
  end

private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end

end
