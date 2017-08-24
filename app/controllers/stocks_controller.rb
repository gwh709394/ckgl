class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.where('document_id is not null').order(id: :desc)
    if params[:search].present?
      @stocks = @stocks.query(params[:search].to_s)
    end
    if params[:date].present?
      d = Date.parse params[:date].to_s
      @stocks = @stocks.where(["created_at >= ? AND created_at <= ?", d.beginning_of_day, d.end_of_day])
    end
    respond_to do |format|
      format.xlsx do
        send_data(Stock.download_xlsx(@stocks),
          #:type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet",
          :type => :xls, :disposition => 'attachment',
          :filename => "库存明细_#{Time.now.strftime("%Y%m%d%H%M")}.xlsx")
      end
      format.html {
        @stocks = @stocks.page(params[:page]).per(15)
      }
    end
    
  end
  
  # def export
  #   @stocks = Stock.where('document_id is not null').order(id: :desc)
  #   if params[:search].present?
  #     @stocks = @stocks.query(params[:search].to_s)
  #   end
  #
  # end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:code, :commodity_id, :stock_type_id, :warehouse_id, :price, :quantity, :sum, :summary, :s_date)
    end
end
