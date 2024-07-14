class UserCoffeesController < ApplicationController
  def index
    @user_coffees = current_user.user_coffees.includes(:coffee)
  end

  def new
    @user_coffee = current_user.user_coffees.build

    if params['coffee']
      @coffee = Coffee.find_by(coffee_params)
    end

    if @coffee
      @user_coffee.coffee = @coffee
    else
      @coffee = @user_coffee.build_coffee
    end
  end

  def create
    @user_coffee = UserCoffee.create(user_coffee_params)
    @user_coffee.user = current_user
    @coffee = Coffee.find_by(coffee_params)
    STDERR.puts @coffee.inspect
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

  private

  def user_coffee_params
    params.require(:user_coffee).permit(:bag_weight, :weight_left, :price, :coffee_id)
  end

  def coffee_params
    params.require(:coffee).permit(:name, :roaster, :roasting_date, :process, :country, :region, :altitude_low, :altitude_high)
  end
end
