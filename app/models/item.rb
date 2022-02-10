class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def error_messages # Only run if the model object has failed to save or update to the database
    errors.messages.flat_map do |attribute, errors|
      errors.map do |error|
        "#{attribute} #{error}"
      end
    end
    # Returns an array of strings(errors)
  end

end
