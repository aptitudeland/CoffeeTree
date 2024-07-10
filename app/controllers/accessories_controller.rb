class AccessoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_accessory, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @accessories = current_user.accessories
  end

  def show
  end

  def new
    @accessory = Accessory.new
  end

  def edit
  end

  def create
    @accessory = current_user.accessories.build(accessory_params)

    if @accessory.save
      redirect_to accessories_path, notice: 'Accessory was successfully created.'
    else
      render :new
    end
  end

  def update
    if @accessory.update(accessory_params)
      redirect_to accessories_path, notice: 'Accessory was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @accessory.destroy
    redirect_to accessories_url, notice: 'Accessory was successfully destroyed.'
  end

  private

  def set_accessory
    @accessory = Accessory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to accessories_path, alert: 'Accessory not found.'
  end

  def authorize_user!
    redirect_to accessories_path, alert: 'You are not authorized.' unless @accessory.user == current_user
  end

  def accessory_params
    params.require(:accessory).permit(:name, :accessory_type, :comments, :grinder_min, :grinder_max, :image_path)
  end
end
