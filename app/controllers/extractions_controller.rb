class ExtractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_extraction, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_brewer_accessories, only: [:new, :edit, :create, :update]
  before_action :set_default_params, only: [:new, :edit]

  def index
    @extractions = current_user.extractions
  end

  def show
  end

  def new
    @extraction = current_user.extractions.build
  end

  def edit
  end

  def create
    @extraction = current_user.extractions.build(extraction_params)

    if @extraction.user_coffee_id.present?
      @extraction.coffee_id = UserCoffee.find(@extraction.user_coffee_id).coffee_id
    else
      flash.now[:alert] = 'Sorry, the extraction needs to be associated with a coffee.'
      render :new, status: :unprocessable_entity and return
    end

    if @extraction.brewing_method_id.present?
      @extraction.brewing_method_id = params[:extraction][:brewing_method_id]
    else
      flash.now[:alert] = 'Sorry, the extraction needs to be associated with a brewing method.'
      render :new, status: :unprocessable_entity and return
    end

    if params[:extraction][:grinder_id].present?
      @extraction.accessories << Accessory.find(params[:extraction][:grinder_id])
    end

    if @extraction.save
      redirect_to @extraction, notice: 'Extraction was successfully created.'
    else
      flash.now[:alert] = @extraction.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @extraction.update(extraction_params)
      if params[:extraction][:grinder_id].present?
        @extraction.accessories << Accessory.find(params[:extraction][:grinder_id])
      end
      redirect_to @extraction, notice: 'Extraction was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, notice: 'Sorry Extraction was NOT updated.'
    end
  end

  def destroy
    if @extraction.destroy
      redirect_to extractions_url, notice: 'Extraction was successfully destroyed.'
    else
      redirect_to extractions_url, status: :unprocessable_entity, notice: 'Sorry, extraction was NOT destroyed.'
    end
  end

  private

  def set_extraction
    @extraction = Extraction.find(params[:id])
  end

  def extraction_params
    params.require(:extraction).permit(
      :brewing_method_id, :user_coffee_id, :weight_in,
      :weight_target, :water_temperature, :pre_infusion_time, :bloom_weight,
      :extraction_time, :weight_out, :comment, :grinder_set, :grinder_id, accessory_ids: []
    )
  end

  def authorize_user!
    redirect_to extractions_path, alert: 'Not authorized.' unless @extraction.user == current_user
  end

  def set_brewer_accessories
    required_types = [
      'Aero press',
      'Cold brew',
      'Drip coffee',
      'Espresso',
      'French press',
      'Moka Pot',
      'Pour-Over',
      'Siphon coffee',
      'Turkish coffee',
      'Vietnamese Phin'
    ]
    @brewer_accessories = current_user.accessories.where(accessory_type: required_types)
  end

  def set_default_params
    # Find the last extraction for the current user with the specified brewing method
    last_extraction = current_user.extractions.last

    # Define default values
    default_weight_in = 18
    default_weight_target = default_weight_in * 2
    default_brewing_method_id = current_user.accessories.brewing_method.last&.id
    default_water_temperature = 93
    default_pre_infusion_time = 8
    default_extraction_time = 20
    default_bloom_weight = default_weight_in * 2
    default_weight_out = default_weight_in * 2
    default_grinder_id = current_user.accessories.grinder.last&.id
    default_grinder_set = 3
    default_user_coffee_id = current_user.user_coffees.last&.id
    default_accessory_ids = last_extraction ? last_extraction.accessories.where.not(accessory_type: Accessory::BREWING_METHODS + ['Grinder']).pluck(:id) : []

    # Set default params based on last extraction or predefined default values
    @default_params = {
      weight_in: last_extraction&.weight_in || default_weight_in,
      weight_target: last_extraction&.weight_target || default_weight_target,
      brewing_method_id: last_extraction&.brewing_method_id || default_brewing_method_id,
      water_temperature: last_extraction&.water_temperature || default_water_temperature,
      pre_infusion_time: last_extraction&.pre_infusion_time || default_pre_infusion_time,
      extraction_time: last_extraction&.extraction_time || default_extraction_time,
      bloom_weight: last_extraction&.bloom_weight || default_bloom_weight,
      weight_out: last_extraction&.weight_out || default_weight_out,
      grinder_id: last_extraction&.accessories&.grinder&.last&.id || default_grinder_id,
      grinder_set: last_extraction&.grinder_set || default_grinder_set,
      user_coffee_id: last_extraction&.user_coffee_id || default_user_coffee_id,
      accessory_ids: default_accessory_ids
    }
  end
end
