class UserCoffeesController < ApplicationController
  def index
    @user_coffees = current_user.user_coffees.include(Coffee)
  end

  def new

  end
end
