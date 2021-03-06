class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :cocktail_rating, :edit, :update]
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
    @review = Review.new
    @reviews = @cocktail.reviews
  end

  def new
    @cocktail = Cocktail.new
    @cocktails = Cocktail.all
  end

  def edit
    @cocktails = Cocktail.all
    @dose = Dose.new
  end

  def update
    @cocktail.update(cocktail_params)
    redirect_to edit_user_cocktail_path(current_user, @cocktail)
  end

  def destroy
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    if @cocktail.save
      redirect_to edit_user_cocktail_path(current_user, @cocktail)
    else
      render :new
    end
  end

private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :user_id,)
  end

end
