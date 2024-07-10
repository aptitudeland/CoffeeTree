class UserCoffeesController < ApplicationController
  def index
    @user_coffees = current_user.user_coffees.includes(:coffee)
  end

  def new
    @user_coffee = current_user.user_coffees.build
    @coffee = @user_coffee.build_coffee

    respond_to do |format|
      format.html
      format.json do
        coffee = Coffee.find_by(name: params[:name])
        render json: { coffee: coffee }
      end
    end

  end

  def create
    @user_coffee = UserCoffee.create(user_coffee_params)
    @user_coffee.user = current_user
    @user_coffee.coffee = Coffee.create(coffee_params) unless @user_coffee.coffee_id

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
    params.require(:coffee).permit(:name, :roaster, :roasting_date, :process, :country, :region, :altitude)
  end
end
