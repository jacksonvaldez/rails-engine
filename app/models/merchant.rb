class Merchant < ApplicationRecord
  has_many :items

  def self.order_by_name
    # Merchant.order('lower(name)')
    Merchant.order(Arel.sql('LOWER(name)'))
  end

  def self.search_by_name(name)
    merchants = Merchant.order_by_name
    merchants.where("name ILIKE ?", "%#{name}%")
  end

  def self.with_most_items(quantity)
    Merchant.joins(:items)
    .select('count(items.*) AS item_count, merchants.id, merchants.name')
    .group('merchants.id')
    .order(item_count: :desc)
    .limit(quantity)
  end

end
