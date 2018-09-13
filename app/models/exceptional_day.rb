class ExceptionalDay < ApplicationRecord
  belongs_to :month
  before_create :set_title
  after_save :change_work_days
  after_destroy :change_work_days
  
  private
  
  def set_title
    self.title = I18n.t("date.russian_day_names")[self.day.wday - 1]
  end
  
  def change_work_days
    if self.is_holiday
      self.destroyed? ? self.month.work_days_size += 1 : self.month.work_days_size -= 1
      self.month.save
    else
      self.destroyed? ? self.month.work_days_size -= 1 : self.month.work_days_size += 1
      self.month.save
    end
  end
end
