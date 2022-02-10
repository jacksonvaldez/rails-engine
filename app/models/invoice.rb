class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.destroy_by_item_count
    Invoice.all.each do |invoice|
      invoice.item_count == 0 ? invoice.destroy : nil
    end
  end

  def item_count
    items.length
  end
end
