class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @cocktails = Cocktail.all
    if params[:query].present?
      @cocktails_results = []
      query = "%#{params[:query]}%"
      results = PgSearch.multisearch(query)
      results.each do |result|
        @cocktails_results << result.searchable
      end
    else
      @cocktails_results = Cocktail.all
    end
  end

  def my_cocktails
    @cocktails = current_user.cocktails
  end

  def show
    @dose = Dose.new
    @reviews = @cocktail.reviews
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
