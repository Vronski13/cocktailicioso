class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:query].present?
      @cocktails = []
      query = "%#{params[:query]}%"
      results = PgSearch.multisearch(query)
      results.each do |result|
        @cocktails << result.searchable
      end
    else
      @cocktails = Cocktail.all
    end
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
    @cocktails = Cocktail.all
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
