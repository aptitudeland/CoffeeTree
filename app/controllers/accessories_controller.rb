class AccessoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_accessory, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]

  def index
    @accessories = current_user.accessories
    @brewing_methods = current_user.accessories.where(accessory_type: Accessory::BREWING_METHODS).reverse
    @other_accessories = current_user.accessories.where.not(accessory_type: Accessory::BREWING_METHODS).reverse
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
    @accessory.grinder_min = 0 # Setting default grinder min value as the DB require
    if @accessory.save
      redirect_to accessories_path, notice: 'Accessory was successfully created.'
    else
      redirect_to accessories_path, notice: 'Sorry the accessory FAILED to be created.'
    end
  end

  def update
    if @accessory.update(accessory_params)
      redirect_to accessory_path, notice: 'Accessory was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, notice: 'Sorry the accessory FAILED to be created.'
    end
  end

  def destroy
    if @accessory.destroy
      redirect_to accessories_url, notice: 'Accessory was successfully destroyed.'
    else
      render :edit, status: :unprocessable_entity, notice: 'Sorry the accessory FAILED to be created.'
    end
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
    params.require(:accessory).permit(:name, :accessory_type, :comments, :grinder_max, :image_path)
  end
end
