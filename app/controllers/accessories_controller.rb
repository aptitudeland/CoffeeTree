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
    accessory_type = @accessory.accessory_type
    @accessory.destroy
    set_new_default(accessory_type)
    redirect_to accessories_url, notice: 'Accessory was successfully destroyed.'
  end

  private

  def set_accessory
    @accessory = Accessory.find(params[:id])
  end

  def authorize_user!
    redirect_to accessories_path, alert: 'You are not authorized.' unless @accessory.user == current_user
  end

  def accessory_params
    params.require(:accessory).permit(:name, :accessory_type, :default, :comments, :grinder_min, :grinder_max, :image_path)
  end

  def set_new_default(accessory_type)
    first_accessory = current_user.accessories.where(accessory_type: accessory_type).first
    if first_accessory
      first_accessory.update(default: true)
    end
  end
end
