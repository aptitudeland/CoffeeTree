class ExtractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_extraction, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_brewer_accessories, only: [:new, :edit, :create, :update]

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

    if @extraction.save
      redirect_to @extraction, notice: 'Extraction was successfully created.'
    else
      render :new
    end
  end

  def update
    if @extraction.update(extraction_params)
      redirect_to @extraction, notice: 'Extraction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @extraction.destroy
    redirect_to extractions_url, notice: 'Extraction was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_extraction
    @extraction = Extraction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def extraction_params
    params.require(:extraction).permit(:brewing_method, :coffee_id, :user_coffee_id, :weight_in, :water_temperature, :pre_infusion_time, :bloom_weight, :extraction_time, :weight_out, :comment, accessory_ids: [])
  end

  # Ensure the current user is authorized to view/edit the extraction
  def authorize_user!
    redirect_to extractions_path, alert: 'Not authorized.' unless @extraction.user == current_user
  end

  # Set the brewer accessories
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
end
