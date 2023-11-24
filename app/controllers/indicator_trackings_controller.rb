class IndicatorTrackingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_indicator
  before_action :set_indicator_tracking, only: %i[ show edit update destroy ]


  # GET /indicator_trackings
  def index
    add_breadcrumb "Indicadores", indicators_path(@indicator)
    add_breadcrumb "Indicador: #{@indicator.name}", indicator_path(@indicator)
    add_breadcrumb "Seguimiento Indicadores", indicator_indicator_trackings_path(@indicator)
    @indicator_trackings = @indicator.indicator_trackings.all.accessible_by(current_ability)
  end

  # GET /indicator_trackings/1
  def show
    add_breadcrumb "Indicadores", indicators_path(@indicator)
    add_breadcrumb "Indicador: #{@indicator.name}", indicator_path(@indicator)
    add_breadcrumb "Seguimiento Indicadores", indicator_indicator_trackings_path(@indicator)
    add_breadcrumb "Ver Seguimiento Indicador"
  end

  # GET /indicator_trackings/new
  def new
    add_breadcrumb "Indicadores", indicators_path(@indicator)
    add_breadcrumb "Indicador: #{@indicator.name}", indicator_path(@indicator)
    add_breadcrumb "Seguimiento Indicadores", indicator_indicator_trackings_path(@indicator)
    add_breadcrumb "Crear seguimiento a indicador"
    @indicator_tracking = @indicator.indicator_trackings.new
  end

  # GET /indicator_trackings/1/edit
  def edit
    add_breadcrumb "Indicadores", :indicators_path
    add_breadcrumb "Indicador: #{@indicator.name}", indicator_path(@indicator)
    add_breadcrumb "Seguimiento Indicadores", :indicator_indicator_trackings_path
    add_breadcrumb "Editar seguimiento a indicador"
  end

  # POST /indicator_trackings
  def create
    add_breadcrumb "Indicadores", :indicators_path
    add_breadcrumb "Indicador: #{@indicator.name}", indicator_path(@indicator)
    add_breadcrumb "Seguimiento Indicadores", :indicator_indicator_trackings_path
    add_breadcrumb "Crear seguimiento a indicador"

    @indicator_tracking = @indicator.indicator_trackings.new(indicator_tracking_params)
    @indicator_tracking.indicator_id = @indicator.id

    if @indicator_tracking.save
      redirect_to indicator_indicator_trackings_path(@indicator), notice: "Seguimiento a indicador creado"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /indicator_trackings/1
  def update
    add_breadcrumb "Editar indicator_tracking"
    if @indicator_tracking.update(indicator_tracking_params)
      redirect_to indicator_indicator_trackings_path(@indicator), notice: "Seguimiento actualizado", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /indicator_trackings/1
  def destroy
    @indicator_tracking.destroy
    redirect_to indicator_indicator_trackings_path(@indicator), notice: "Registro eliminado", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indicator_tracking
      @indicator_tracking = IndicatorTracking.find(params[:id])
    end

  def set_indicator
      @indicator = Indicator.all.accessible_by(current_ability).find(params[:indicator_id])
  end

    # Only allow a list of trusted parameters through.
    def indicator_tracking_params
      params.require(:indicator_tracking).permit(:report_date, :value)
    end
end
