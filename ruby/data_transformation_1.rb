require 'date'
require 'json'

api_response = "{\"sales_data\":[{\"customer_id\":101,\"name\":\"Alice Corp\",\"orders\":[{\"date\":\"2025-01-10\",\"amount\":1500,\"products\":[\"laptop\",\"mouse\"]},{\"date\":\"2025-02-15\",\"amount\":800,\"products\":[\"keyboard\"]},{\"date\":\"2025-03-20\",\"amount\":2200,\"products\":[\"monitor\",\"laptop\"]}]},{\"customer_id\":102,\"name\":\"Bob Inc\",\"orders\":[{\"date\":\"2025-01-05\",\"amount\":600,\"products\":[\"mouse\",\"pad\"]},{\"date\":\"2025-01-25\",\"amount\":1200,\"products\":[\"laptop\"]}]}]}"


response = JSON.parse(api_response, symbolize_names: true)
monthly_sales = {}

flattened_orders = response[:sales_data].flat_map do |sale|
  sale[:orders].map do |order|
    {
      customer_id: sale[:customer_id],
      customer_name: sale[:name],
      date: order[:date],
      amount: order[:amount],
      products: order[:products]
    }
  end
end

monthly_groups = flattened_orders.group_by do |order|
  #more exercises w/ flat & group_by
  Date.parse(order[:date]).strftime("%Y-%m")
end

puts "monthly_groups====="
pp monthly_groups

monthly_sales = monthly_groups.transform_values do |month|
  puts "month===="
  puts month
  # more exercises with this
  customer_data = month.each_with_object({}) do |order, month_order|
    customer_id = order[:customer_id]
    month_order[customer_id] ||= { customer_id:, name: order[:customer_name], monthly_total: 0 }
    month_order[customer_id][:monthly_total] += order[:amount]
  end

  {
    total_revenue: month.sum { |o| o[:amount] },
    customer_count: customer_data.size,
    customers: customer_data.values
  }
end


# response[:sales_data].each do |sale|  
#   sale[:orders].each do |customer_sale|
#     date = Date.parse(customer_sale[:date]).strftime("%Y-%m")
#     monthly_sales[date] ||= {}
#     monthly_sales[date][:total_revenue] ||= 0
#     monthly_sales[date][:total_revenue] += customer_sale[:amount]
#     monthly_sales[date][:customer_count] ||= 0
#     monthly_sales[date][:customers] ||= []
#     # monthly_sales[date][:customers].find customer?
#     existing_customer = monthly_sales[date][:customers].find do |customer|
#       customer[:customer_id] == sale[:customer_id]
#     end

#     if existing_customer
#       existing_customer[:monthly_total] += customer_sale[:amount]
#     else
#       monthly_sales[date][:customers].push({
#         customer_id: sale[:customer_id],
#         customer_name: sale[:name],
#         monthly_total: customer_sale[:amount]
#       })
#     end

#     monthly_sales[date][:customer_count] = monthly_sales[date][:customers].length
#   end
# end 
puts "monthly_sales====="
pp monthly_sales


# {
#   "2025-01" => {
#     "total_revenue" => 3300,
#     "customer_count" => 2,
#     "customers" => [
#       { "customer_id" => 101, "name" => "Alice Corp", "monthly_total" => 1500 },
#       { "customer_id" => 102, "name" => "Bob Inc", "monthly_total" => 1800 }
#     ]
#   },
#   "2025-02" => {
#     "total_revenue" => 800,
#     "customer_count" => 1,
#     "customers" => [
#       { "customer_id" => 101, "name" => "Alice Corp", "monthly_total" => 800 }
#     ]
#   },
#   "2025-03" => {
#     "total_revenue" => 2200,
#     "customer_count" => 1,
#     "customers" => [
#       { "customer_id" => 101, "name" => "Alice Corp", "monthly_total" => 2200 }
#     ]
#   }
# }