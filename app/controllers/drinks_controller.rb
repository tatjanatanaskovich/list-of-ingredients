class DrinksController < ApiController
  before_action :set_drink, only: [:show, :update, :destroy]

  def index
    @drinks = Drink.select("id, title").all
    render json: @drinks.to_json
  end

  def show
    @drink = Drink.find(params[:id])
    render json: @drink.to_json(:include => { :ingredients => { :only => [:id, :description] }})
  end

  def create
    @drink = Drink.new(drink_params)

    if @drink.save
      render json: @drink, status: :created, location: @drink
    else
      render json: @drink.errors, status: :unprocessable_entity
    end
  end

  def update
    if @drink.update(drink_params)
      render json: @drink
    else
      render json: @drink.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @drink.destroy
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end

    def drink_params
      params.require(:drink).permit(:title, :description, :steps, :source)
    end
end
