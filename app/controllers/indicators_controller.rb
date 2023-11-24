class IndicatorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_indicator, only: %i[ show edit update destroy ]

  add_breadcrumb "Indicadores", :indicators_path

  # GET /indicators
  def index
    @indicators = Indicator.all.accessible_by(current_ability)
  end

  # GET /indicators/1
  def show
    add_breadcrumb "Ver indicador"
  end

  # GET /indicators/new
  def new
    add_breadcrumb "Crear indicador"
    @indicator = Indicator.new
  end

  # GET /indicators/1/edit
  def edit
    add_breadcrumb "Editar indicador"
  end

  # POST /indicators
  def create
    add_breadcrumb "Crear indicador"
    @indicator = Indicator.new(indicator_params)

    if @indicator.save
      redirect_to @indicator, notice: "Registro creado"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /indicators/1
  def update
    add_breadcrumb "Editar indicador"
    if @indicator.update(indicator_params)
      redirect_to @indicator, notice: "Registro actualizado", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /indicators/1
  def destroy
    @indicator.destroy
    redirect_to indicators_url, notice: "Registro eliminado", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def indicator_params
      params.require(:indicator).permit(:name, :description, :target_value, :indicator_type, :base_linea)
    end
end
