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
    unless @service.countable
      month_work_days = Month.find_by(:year => @start_date.year,:number => @start_date.month).work_days_size
      if @discount_id.present?
        @price = @service.discount_price(@discount_id)
      elsif @client_id.present?
        if client = Client.find(@client_id)
          @price = @service.discount_client_price(client)
        end
      end
      ((@price / month_work_days) * WorkDaysCalculator.new(@start_date,@end_date).call()).round
    else
      @price * WorkDaysCalculator.new(@start_date,@end_date).call()
    end
  end
  
end