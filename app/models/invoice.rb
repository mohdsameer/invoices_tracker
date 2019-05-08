class Invoice < ApplicationRecord
  def self.filter(from, to)
    self.where("invoice_date BETWEEN ? AND ?", from, to)
  end

  def total
    self.sum(:amount)
  end
end
