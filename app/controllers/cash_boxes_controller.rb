class CashBoxesController < ApplicationController
  def show
    @incomes = current_cash_box.incomes
    @transfers = current_cash_box.transfers
  end
end
