module ApplicationHelper
  def pending_transfers
    Transfer.where(['status = ? and to_cashbox = ?', 0, current_branch.id])
  end
  
  def current_class?(path)
    return "active" if request.path == path
    ''
  end
end
