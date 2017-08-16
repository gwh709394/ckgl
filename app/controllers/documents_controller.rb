class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all.order(id: :desc)
    if params[:opt].to_i == StockingType::RECEVING  || params[:opt].nil? 
      a = StockType.where(s_type: StockingType::RECEVING).map{|x| x.id}
    else
      a = StockType.where(s_type: StockingType::SHIPPING).map{|x| x.id}  
    end
    @documents = @documents.where('stock_type_id in (?)', a)
    @documents = @documents.page(params[:page])
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    
  end

  # GET /documents/new
  def new
    @document = Document.new
    @commodities = Commodity.all.page(params[:page]).per(2)
  end

  # GET /documents/1/edit
  def edit
    @commodities = Commodity.all.page(params[:page]).per(2)
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        params.each do |key,value|
          if key.include? 'quantity'
            c  = Commodity.find(key.split('_')[0].to_i)
            quan = value.to_i.abs
            if @document.stock_type_id == StockingType::SHIPPING
              quan = -quan
            end
            s = @document.stocks.create(commodity_id: c.id, quantity: quan, warehouse_id: @document.warehouse_id)
            CommodityWarehouseRelationship.update_stock(@document.warehouse_id, c.id, quan)
          end
        end
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:number, :stock_type_id, :warehouse_id, :d_date, :staff_id, :summary)
    end
end
