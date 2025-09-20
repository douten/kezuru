require 'json'
require 'set'

api_response = "{\"orders\":[{\"id\":\"ORD-001\",\"customer\":{\"id\":501,\"name\":\"TechCorp Inc\",\"tier\":\"enterprise\"},\"items\":[{\"product_id\":\"LAPTOP-X1\",\"name\":\"Gaming Laptop\",\"category\":\"electronics\",\"price\":1299.99,\"quantity\":2},{\"product_id\":\"MOUSE-A2\",\"name\":\"Wireless Mouse\",\"category\":\"electronics\",\"price\":49.99,\"quantity\":5}],\"order_date\":\"2025-01-15\"},{\"id\":\"ORD-002\",\"customer\":{\"id\":502,\"name\":\"StartupXYZ\",\"tier\":\"standard\"},\"items\":[{\"product_id\":\"DESK-B1\",\"name\":\"Standing Desk\",\"category\":\"furniture\",\"price\":599.99,\"quantity\":3},{\"product_id\":\"CHAIR-C1\",\"name\":\"Ergonomic Chair\",\"category\":\"furniture\",\"price\":299.99,\"quantity\":2}],\"order_date\":\"2025-01-16\"},{\"id\":\"ORD-003\",\"customer\":{\"id\":501,\"name\":\"TechCorp Inc\",\"tier\":\"enterprise\"},\"items\":[{\"product_id\":\"LAPTOP-X1\",\"name\":\"Gaming Laptop\",\"category\":\"electronics\",\"price\":1299.99,\"quantity\":1},{\"product_id\":\"MONITOR-D1\",\"name\":\"4K Monitor\",\"category\":\"electronics\",\"price\":399.99,\"quantity\":2}],\"order_date\":\"2025-01-18\"},{\"id\":\"ORD-004\",\"customer\":{\"id\":503,\"name\":\"Design Studio\",\"tier\":\"premium\"},\"items\":[{\"product_id\":\"CHAIR-C1\",\"name\":\"Ergonomic Chair\",\"category\":\"furniture\",\"price\":299.99,\"quantity\":4},{\"product_id\":\"LAMP-E1\",\"name\":\"LED Desk Lamp\",\"category\":\"furniture\",\"price\":89.99,\"quantity\":2}],\"order_date\":\"2025-01-20\"},{\"id\":\"ORD-005\",\"customer\":{\"id\":504,\"name\":\"Remote Team\",\"tier\":\"standard\"},\"items\":[{\"product_id\":\"MOUSE-A2\",\"name\":\"Wireless Mouse\",\"category\":\"electronics\",\"price\":49.99,\"quantity\":10},{\"product_id\":\"KEYBOARD-F1\",\"name\":\"Mechanical Keyboard\",\"category\":\"electronics\",\"price\":129.99,\"quantity\":8}],\"order_date\":\"2025-01-22\"}]}"
data = JSON.parse(api_response, symbolize_names: true)

# categories > { ... products > {... top_customers } }
# 

flattened_items = data[:orders].flat_map do |order|
  order[:items].map do |item|
    { 
      **item,
      order_id: order[:id],
      customer: order[:customer]
    }
  end
end

category_groups = flattened_items.group_by do |order|
  order[:category]
end

pp category_groups

category_sales = category_groups.transform_values do |category_data|
  temp_product_order = {}

  category_total_revenue = 0
  category_total_units = 0
  
  products = category_data.each_with_object({}) do |product_data, product|
    product_name = product_data[:name]
    product[product_name] ||= {total_revenue: 0, units_sold: 0, customers: {}}
    
    # calculate avg_order_size
    temp_product_order[product_name] ||= Set.new
    temp_product_order[product_name].add(product_data[:order_id])
    avg_order_size = product[product_name][:units_sold].to_f / temp_product_order[product_name].size
    product_total_price = (product_data[:price] * product_data[:quantity])

    category_total_revenue += product_total_price
    category_total_units += product_data[:quantity]

    product[product_name][:total_revenue] += product_total_price
    product[product_name][:total_revenue] = product[product_name][:total_revenue].round(2)
    product[product_name][:units_sold] += product_data[:quantity]  
    product[product_name][:avg_order_size] = avg_order_size
    
    # customer data
    customer_id = product_data[:customer][:id]
    product[product_name][:customers][customer_id] ||= 
      { customer_id:,
      customer_name: product_data[:customer][:name],
      total_purchased: 0.0,
      units: 0 }
    product[product_name][:customers][customer_id][:total_purchased] += product_total_price
    product[product_name][:customers][customer_id][:units] += product_data[:quantity]
  end

  products.transform_values do |product_data|
    product_data[:top_customers] = product_data[:customers]
      .values
      .sort_by{ |c| -c[:total_purchased]}
    product_data.delete(:customers)
    product_data
  end


  {
    total_revenue: category_total_revenue,
    total_units: category_total_units,
    product_count: products.size,
    products:
  }
end

pp category_sales