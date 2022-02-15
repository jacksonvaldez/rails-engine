class MostItemsSerializer

  def self.merchants_index(merchants)
    data = merchants.map do |merchant|
      {
        id: merchant.id,
        type: 'items_sold',
        attributes: {
          name: merchant.name,
          count: merchant.item_count
        }
      }
    end

    {
      data: data
    }
  end

end
