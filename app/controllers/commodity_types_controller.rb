class CommodityTypesController < ApplicationController
  before_action :set_commodity_type, only: [:show, :edit, :update, :destroy]

  # GET /commodity_types
  # GET /commodity_types.json
  def index
    @commodity_types = CommodityType.all
  end

  # GET /commodity_types/1
  # GET /commodity_types/1.json
  def show
  end

  # GET /commodity_types/new
  def new
    @commodity_type = CommodityType.new
  end

  # GET /commodity_types/1/edit
  def edit
  end

  # POST /commodity_types
  # POST /commodity_types.json
  def create
    @commodity_type = CommodityType.new(commodity_type_params)

    respond_to do |format|
      if @commodity_type.save
        format.html { redirect_to commodity_types_url, notice: 'Commodity type was successfully created.' }
        format.json { render :show, status: :created, location: @commodity_type }
      else
        format.html { render :new }
        format.json { render json: @commodity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodity_types/1
  # PATCH/PUT /commodity_types/1.json
  def update
    respond_to do |format|
      if @commodity_type.update(commodity_type_params)
        format.html { redirect_to commodity_types_url, notice: 'Commodity type was successfully updated.' }
        format.json { render :show, status: :ok, location: @commodity_type }
      else
        format.html { render :edit }
        format.json { render json: @commodity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodity_types/1
  # DELETE /commodity_types/1.json
  def destroy
    @commodity_type.destroy
    respond_to do |format|
      format.html { redirect_to commodity_types_url, notice: 'Commodity type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity_type
      @commodity_type = CommodityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commodity_type_params
      params.require(:commodity_type).permit(:name)
    end
end
