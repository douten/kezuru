require 'json'
require 'date'

json_string = '[{"sale_id":"S001","rep":{"id":"REP001","name":"Alice","region":"West"},"customer":{"id":"C001","company":"TechCorp","industry":"software"},"products":[{"id":"P001","name":"License A","price":1000,"quantity":5},{"id":"P002","name":"Support","price":200,"quantity":1}],"date":"2024-03-15"},{"sale_id":"S002","rep":{"id":"REP001","name":"Alice","region":"West"},"customer":{"id":"C002","company":"StartupXYZ","industry":"fintech"},"products":[{"id":"P001","name":"License A","price":1000,"quantity":2},{"id":"P003","name":"Training","price":500,"quantity":1}],"date":"2024-03-16"},{"sale_id":"S003","rep":{"id":"REP002","name":"Bob","region":"East"},"customer":{"id":"C003","company":"BigBank","industry":"finance"},"products":[{"id":"P002","name":"Support","price":200,"quantity":3},{"id":"P003","name":"Training","price":500,"quantity":2}],"date":"2024-03-17"},{"sale_id":"S004","rep":{"id":"REP002","name":"Bob","region":"East"},"customer":{"id":"C001","company":"TechCorp","industry":"software"},"products":[{"id":"P001","name":"License A","price":1000,"quantity":1}],"date":"2024-03-18"}]'
response = JSON.parse(json_string, symbolize_names: true)
# pp response

region_group = response.group_by do |sale|
  sale[:rep][:region]
end

region_sales = region_group.transform_values do |sales|
  # region_stat = sales.each_with_object(nil) do |sale, acc_obj|
  #   acc_obj ||= {
  #     total_revenue: 0.0,
  #     rep_count: 0,
  #     customer_count: 0,
  #     avg_deal_size: 0.0,
  #     top_products: {},
  #     industries_served: {}
  #   }
  #   p acc_obj
  #   acc_obj[:total_revenue] += sale[:products].sum{|p| p[:price] * p[:quantity]}
  # end
  
  region_stat = sales.reduce do |sale, acc_obj|
    p acc_obj
    puts "\n"
    p sale
    {hi:"there"}
    # acc_obj[:total_revenue] += sale[:products].sum{|p| p[:price] * p[:quantity]}
  end
  puts "\n"
  puts region_stat
end

# region_sales

# pp region_group

