module OperationActions
  extend ActiveSupport::Concern
  
  included do
    
    before_action :set_operation,only: [:show,:destroy]
    
    def index
      @collection = current_cash_box.current_cash_box_session.send(controller_name.downcase).order("created_at DESC")
      if params[:q]
        filter_query(params[:q])
      end
    end
    
    def new
      @operation = ApplicationRecord.const_get(controller_name.chop.capitalize).new
    end
    
    def show
      
    end
    
    def create
      @operation = current_cash_box.exec_operation(controller_name.downcase,self.send("#{controller_name.downcase}_params"))
      if @operation.save
        redirect_to self.send("#{controller_name.downcase.chop}_path",@operation.id)
      else
        render :new
      end
    end
    
    private
    
    def filter_query(query)
      @filter_params = {}
      query.each do |k,v|
        @filter_params[k.to_sym] = v
        @collection = @collection.public_send("#{k}_filter",v)
      end
    end
    
    def set_operation
      @operation = ApplicationRecord.const_get(controller_name.chop.capitalize).find(params[:id])
    end
    
  end
  
  
end