module CashBoxesHelper
  def selected_param title
    if @filter_params
      @filter_params[title]
    else
      0
    end
  end
  
  def operation_path(operation)
    case operation.class.name
      when "Income"
        income_path(operation.id)
      when "Consumption"
        consumption_path(operation.id)
      when "Encashment"
        encashment_path(operation.id)
      when  "Transfer"
        transfer_path(operation.id)
    end
  end
  
  
  def operation_attributes(operation)
    operation.class.columns_hash.select{|k,v| v.name !~ /(\Aid\z|_at|service|cash_box)/}.values
  end
  
  def input_wrapper(attr,f)
    
    case attr.name
      when "client_id"
        render 'clients/find_client_input',f: f
      when "amount"
        raw("
          <div class='form-group'>
          #{f.label attr.name.to_sym}
          #{f.number_field attr.name.to_sym,class: 'form-control',min: 0,step: '0.01'}
          </div>
        ")
      when "comment"
        raw("
          <div class='form-group'>
          #{f.label attr.name.to_sym}
          #{f.text_area attr.name.to_sym,class: 'form-control'}
          </div>
        ")
      else
        raw("
          <div class='form-group'>
          #{f.label attr.name.to_sym}
          #{f.text_field attr.name.to_sym,class: 'form-control'}
          </div>
        ")
    end
  end
  
  def operation_status(operation)
    if operation.class.name != "Transfer"
      "bg-danger" if operation.canceled?
    end
  end
end
