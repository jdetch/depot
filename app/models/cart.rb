class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    # find_by() is a streamlined version of where();
    # Instead of returning an array of results, it returns either an existing LineItem or nil
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    # Array::sum() method sums the prices of each item in the cart
    line_items.to_a.sum { |item| item.total_price }
  end

end
