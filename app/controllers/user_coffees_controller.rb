class UserCoffeesController < ApplicationController
  before_action :set_user_coffee, only: %w[show edit update destroy]
  def index
    @user_coffees = current_user.user_coffees.active.includes(:coffee)
  end

  def show
    @coffee = UserCoffee.find(params[:id])
  end

  def new
    @user_coffee = current_user.user_coffees.build

    if params["coffee"]
      @coffee = Coffee.find_by(coffee_params)
      if @coffee
        @user_coffee.coffee = @coffee
      else
        @coffee = @user_coffee.build_coffee(coffee_params)
      end
    else
      @coffee = @user_coffee.build_coffee
    end
  end

  def create
    @user_coffee = UserCoffee.create(user_coffee_params)
    @user_coffee.user = current_user
    @coffee = Coffee.find_by(coffee_params)

    unless @coffee
      @coffee = Coffee.create(coffee_params)
    end
    @user_coffee.coffee = @coffee

    if @user_coffee.save
      redirect_to user_coffees_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @user_coffee.update(user_coffee_params)
      head :ok
    else
      render :back, status: :unprocessable_entity
    end

  end

  def destroy

  end

  private

  def set_user_coffee
    @user_coffee = UserCoffee.find(params[:id])
  end

  def user_coffee_params
    params.require(:user_coffee).permit(:bag_weight, :weight_left, :price, :coffee_id, :archived)
  end

  def coffee_params
    params.require(:coffee).permit(:name, :roaster, :roasting_date, :process, :country, :region, :altitude_low, :altitude_high)
  end
end
