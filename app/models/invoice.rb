class Invoice < ApplicationRecord
  validates :amount, presence: true, numericality: true
  validates :invoice_date, presence: true

  def self.filter(from, to)
    where("invoice_date BETWEEN ? AND ?", from, to).order('invoice_date DESC')
  end

  def self.total
    sum('amount')
  end
end
