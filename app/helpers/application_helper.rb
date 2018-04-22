module ApplicationHelper
  def pending_transfers
    Transfer.where(['status = ? and to_cashbox = ?', 0, current_branch.id])
  end
end
