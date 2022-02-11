class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :delete_all
  has_many :items, through: :invoice_items

  def self.with_no_items
    Invoice.select('invoices.id, count(items.id) AS item_count')
           .joins("FULL OUTER JOIN invoice_items ON invoices.id = invoice_items.invoice_id FULL OUTER JOIN items ON items.id = invoice_items.item_id")
           .group("invoices.id")
           .map { |invoice| invoice.item_count == 0 ? Invoice.find(invoice.id) : nil }.compact
  end

end
