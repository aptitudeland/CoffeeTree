class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @extractions = current_user.extractions.order(created_at: :desc).limit(3)
    @user_coffees = current_user.user_coffees.where(archived: false).order(created_at: :desc).limit(3)
    @default_accessories = current_user.accessories.where(default: true)
  end
end
