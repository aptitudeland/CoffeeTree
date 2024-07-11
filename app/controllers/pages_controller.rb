class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      redirect_to pages_dashboard_path
    else
      render 'home'
    end
  end

  def dashboard
    @extractions = current_user.extractions.order(created_at: :desc).limit(3)
    @user_coffees = current_user.user_coffees.where(archived: false).order(created_at: :desc).limit(3)
    @brewing_methods = current_user.accessories.where(accessory_type: Accessory::BREWING_METHODS).last(3).reverse
    @other_accessories = current_user.accessories.where.not(accessory_type: Accessory::BREWING_METHODS).last(5).reverse
  end
end
