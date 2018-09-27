class RequireAmountCalculator
  
  def initialize(params)
    @service = Service.find(params[:service_id])
    @price = @service.price
    @start_date = params[:start_date].to_date
    @end_date = params[:end_date].to_date
    @discount_id = params[:single_discount_id]
    @client_id = params[:discount_client_id]
  end
  
  def call
    days_size = WorkDaysCalculator.new(@start_date,@end_date).call()
    unless @service.countable
      month_work_days = Month.find_by(:year => @start_date.year,:number => @start_date.month).work_days_size
      if @discount_id.present?
        @price = @service.discount_price(@discount_id)
      elsif @client_id.present?
        if client = Client.find(@client_id)
          @price = @service.discount_client_price(client)
        end
      end
      {:required_amount => ((@price / month_work_days) * days_size).round, :days_size => days_size}
    else
      {:required_amount => @price * days_size,:days_size => days_size}
    end
  end
  
end