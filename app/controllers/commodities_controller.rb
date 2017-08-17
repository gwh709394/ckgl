class CommoditiesController < ApplicationController
  before_action :set_commodity, only: [:show, :edit, :update, :destroy]

  # GET /commodities
  # GET /commodities.json
  def index
    @commodities = Commodity.all
    if params[:search].present?
      @commodities = @commodities.query(params[:search].to_s)
    end
    @commodities = @commodities.page(params[:page])
    respond_to do |format|
      format.html
      format.js {} 
      format.json { 
         render json: {:commodities => @commodities}
      } 
    end
  end

  # GET /commodities/1
  # GET /commodities/1.json
  def show
  end

  # GET /commodities/new
  def new
    @commodity = Commodity.new
    @commodity.low_stock = 3
    @commodity.high_stock = 30
  end

  # GET /commodities/1/edit
  def edit
  end

  # POST /commodities
  # POST /commodities.json
  def create
    @commodity = Commodity.new(commodity_params)

    respond_to do |format|
      if @commodity.save
        format.html { redirect_to commodities_url, flash: {success: '操作成功.' } }
        format.json { render :show, status: :created, location: @commodity }
      else
        format.html { render :new }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodities/1
  # PATCH/PUT /commodities/1.json
  def update
    respond_to do |format|
      if @commodity.update(commodity_params)
        format.html { redirect_to commodities_url, flash: {success: '操作成功.' } }
        format.json { render :show, status: :ok, location: @commodity }
      else
        format.html { render :edit }
        format.json { render json: @commodity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodities/1
  # DELETE /commodities/1.json
  def destroy
    @commodity.destroy
    respond_to do |format|
      format.html { redirect_to commodities_url, flash: {success: '操作成功.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity
      @commodity = Commodity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commodity_params
      params.require(:commodity).permit(:name, :code, :commodity_type_id, :bar_code, :specification, :unit, :cost, :sale, :low_stock, :high_stock)
    end
end
