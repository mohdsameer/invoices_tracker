class Invoice < ApplicationRecord
  validates :amount, presence: true, numericality: true
  validates :invoice_date, presence: true

  def self.filter(from, to)
    where("invoice_date BETWEEN ? AND ?", from, to).order('created_at DESC')
  end

  def self.total_for(invoice_ids)
    Invoice.where(id: invoice_ids).sum('amount')
  end
end
