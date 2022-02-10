class ItemSerializer

  def self.items_index(items)

    data = items.map do |item|
      {
        id: item.id.to_s,
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    end

    {
      data: data
    }
  end

  def self.items_show(item)
    data = {
      id: item.id.to_s,
      type: 'item',
      attributes: {
        name: item.name,
        description: item.description,
        unit_price: item.unit_price,
        merchant_id: item.merchant_id
      }
    }

    {
      data: data
    }
  end

  def self.return_error(errors)
    {
      "message": "your query could not be completed",
      "errors": errors
    }
  end

end
