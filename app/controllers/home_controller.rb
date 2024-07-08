class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @accessories = current_user.accessories
  end
end
