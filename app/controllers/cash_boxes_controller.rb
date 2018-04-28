class CashBoxesController < ApplicationController
  def show
    @incomes = current_cash_box.incomes
    @transfers = current_cash_box.transfers
    @consumptions = current_cash_box.consumptions
    @encashments = current_cash_box.encashments
  end
end
