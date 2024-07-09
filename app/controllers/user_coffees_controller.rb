class UserCoffeesController < ApplicationController
  def index
    @user_coffees = current_user.user_coffees.includes(:coffee)
  end

  def new
    @user_coffee = current_user.user_coffees.build
    @coffee = @user_coffee.build_coffee
  end

  def create
    @user_coffee = UserCoffee.new(user_coffee_params)
    @user_coffee.user = current_user

    if @user_coffee.save
      redirect_to user_coffees_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_coffee_params
    params.require(:user_coffee).permit(:bag_weight, :coffee_id, :weight_left, :price)
  end
end
