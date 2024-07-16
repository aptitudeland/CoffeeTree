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
    # @extraction.user = current_user

    if @extraction.user_coffee_id.present?
      @extraction.coffee_id = UserCoffee.find(@extraction.user_coffee_id).coffee_id
    else
      render :new, status: :unprocessable_entity, notice: 'Sorry the extractionneed to be associated with a coffee.'
    end

    if @extraction.save
      redirect_to @extraction, notice: 'Extraction was successfully created.'
    else
      render :new, status: :unprocessable_entity, notice: 'Sorry the extraction FAILED to be created.'
    end
  end

  def update
    if @extraction.update(extraction_params)
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
      :brewing_method, :coffee_id, :user_coffee_id, :weight_in,
      :weight_target, :water_temperature, :pre_infusion_time, :bloom_weight,
      :extraction_time, :weight_out, :comment, :grinder_set, accessory_ids: []
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
    last_extraction = current_user.extractions.where(brewing_method: params[:brewing_method]).order(created_at: :desc).first
    default_weight_in = 18
    @default_params = {
      weight_in: last_extraction&.weight_in || default_weight_in,
      weight_target: last_extraction&.weight_target || (default_weight_in * 2),
      water_temperature: last_extraction&.water_temperature || 93,
      pre_infusion_time: last_extraction&.pre_infusion_time || 8,
      extraction_time: last_extraction&.extraction_time || 20,
      weight_out: last_extraction&.weight_out || (default_weight_in * 2),
      grinder_set: last_extraction&.grinder_set || 3,
      user_coffee_id: last_extraction&.user_coffee_id || nil,
      comment: last_extraction&.comment || ""
    }
  end
end
