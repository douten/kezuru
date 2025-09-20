require 'pry-byebug'

# 1
# users = [
#   { name: "Alice", role: "admin", age: 28 },
#   { name: "Bob", role: "user", age: 34 },
#   { name: "Carol", role: "admin", age: 25 },
#   { name: "Dave", role: "user", age: 29 }
# ]

# roles = users.group_by{|user| user[:role]}
# pp roles

# 2
# orders = [
#   { id: 101, amount: 45.50, customer_id: 1, status: "shipped" },
#   { id: 102, amount: 120.00, customer_id: 2, status: "pending" },
#   { id: 103, amount: 75.25, customer_id: 1, status: "shipped" },
#   { id: 104, amount: 200.00, customer_id: 3, status: "shipped" },
#   { id: 105, amount: 35.00, customer_id: 2, status: "cancelled" }
# ]
# price_range = orders.group_by do |order|
#   if order[:amount] < 50
#     "small"
#   elsif order[:amount] < 150
#     "medium"
#   else
#     "large"
#   end
# end
# pp price_range

# 3
# posts = [
#   { title: "Ruby Tips", author: "Alice", tags: ["ruby", "programming"], views: 1500 },
#   { title: "JS Frameworks", author: "Bob", tags: ["javascript", "react"], views: 2300 },
#   { title: "Ruby on Rails", author: "Alice", tags: ["ruby", "rails", "web"], views: 1800 },
#   { title: "CSS Grid", author: "Carol", tags: ["css", "design"], views: 900 },
#   { title: "React Hooks", author: "Bob", tags: ["javascript", "react", "hooks"], views: 2100 }
# ]
# tag_groups = posts.group_by do |post|
#   post[:tags][0]
# end
# pp tag_groups

# 4
# sales = [
#   { rep: "Alice", region: "North", product: "laptop", amount: 1200, quarter: "Q1" },
#   { rep: "Bob", region: "South", product: "phone", amount: 800, quarter: "Q1" },
#   { rep: "Alice", region: "North", product: "tablet", amount: 600, quarter: "Q2" },
#   { rep: "Carol", region: "West", product: "laptop", amount: 1200, quarter: "Q1" },
#   { rep: "Bob", region: "South", product: "laptop", amount: 1100, quarter: "Q2" },
#   { rep: "Dave", region: "East", product: "phone", amount: 750, quarter: "Q1" }
# ]
# tier_sales = sales.group_by do |sale|
#   if sale[:amount] < 500
#     "low"
#   elsif sale[:amount] <= 999
#     "medium"
#   else
#     "high"
#   end
# end
# pp tier_sales

# 5
# employees = [
#   { name: "Alice", dept: "Engineering", level: "Senior", salary: 120000 },
#   { name: "Bob", dept: "Marketing", level: "Junior", salary: 65000 },
#   { name: "Carol", dept: "Engineering", level: "Senior", salary: 125000 },
#   { name: "Dave", dept: "Marketing", level: "Senior", salary: 95000 },
#   { name: "Eve", dept: "Engineering", level: "Junior", salary: 75000 }
# ]
# dept = employees.group_by{|e| "#{e[:dept]}-#{e[:level]}"}
# pp dept

# 6
# interactions = [
#   { customer_id: 101, action: "email_open", campaign: "summer_sale", timestamp: "2024-06-01", value: 0 },
#   { customer_id: 101, action: "website_visit", campaign: "summer_sale", timestamp: "2024-06-02", value: 0 },
#   { customer_id: 101, action: "purchase", campaign: "summer_sale", timestamp: "2024-06-03", value: 150 },
#   { customer_id: 102, action: "email_open", campaign: "back_to_school", timestamp: "2024-08-15", value: 0 },
#   { customer_id: 102, action: "email_click", campaign: "back_to_school", timestamp: "2024-08-15", value: 0 },
#   { customer_id: 103, action: "social_media_click", campaign: "holiday", timestamp: "2024-12-01", value: 0 },
#   { customer_id: 103, action: "website_visit", campaign: "holiday", timestamp: "2024-12-01", value: 0 },
#   { customer_id: 103, action: "cart_abandon", campaign: "holiday", timestamp: "2024-12-02", value: 0 },
#   { customer_id: 104, action: "email_open", campaign: "summer_sale", timestamp: "2024-06-01", value: 0 },
#   { customer_id: 104, action: "purchase", campaign: "summer_sale", timestamp: "2024-06-01", value: 89 }
# ]
# customer_actions = interactions.group_by{|i| i[:customer_id]}
#   .transform_values{|i| i.map{|attr| attr[:action]}}
# puts "====== customer_actions"
# pp customer_actions
# puts "\n"
# engagement_group = interactions.group_by do |itn|
#   actions = customer_actions[itn[:customer_id]]
#   # actions = int[:action]
#   if actions.include?("purchase")
#     "converters"
#   # elsif actions.any?{|a| a.end_with?("click")} || actions.any?{|a| a.end_with?("visit")}
#   elsif actions.any? { |a| a.include?("click") || a.include?("visit") }
#     "engaged"
#   else
#     "passive"
#   end
# end
# puts "===== engagement_group"
# pp engagement_group

# 7
# reviews = [
#   { product_id: "laptop_123", user_id: 501, rating: 5, verified_purchase: true, review_length: 250, category: "electronics" },
#   { product_id: "laptop_123", user_id: 502, rating: 4, verified_purchase: false, review_length: 100, category: "electronics" },
#   { product_id: "phone_456", user_id: 503, rating: 2, verified_purchase: true, review_length: 500, category: "electronics" },
#   { product_id: "phone_456", user_id: 504, rating: 1, verified_purchase: true, review_length: 800, category: "electronics" },
#   { product_id: "book_789", user_id: 505, rating: 5, verified_purchase: true, review_length: 150, category: "books" },
#   { product_id: "book_789", user_id: 506, rating: 5, verified_purchase: false, review_length: 50, category: "books" },
#   { product_id: "laptop_123", user_id: 507, rating: 3, verified_purchase: true, review_length: 300, category: "electronics" },
#   { product_id: "shoe_999", user_id: 508, rating: 4, verified_purchase: true, review_length: 75, category: "fashion" }
# ]
# product_group = reviews.group_by{|r| r[:product_id]}
# product_stats = product_group.transform_values do |products|
#   avg_rating = (products.sum{|p| p[:rating]} / products.length.to_f).round(2)
#   verified_pct = (products.sum{|p| p[:verified_purchase] == true ? 1 : 0 } / products.length.to_f).round(2)
#   { avg_rating:, verified_pct: }
# end
# product_review_health = reviews.group_by do |review|
#   id = review[:product_id]
#   p_stat = product_stats[id]
#   if p_stat[:avg_rating] >= 4.5 && p_stat[:verified_pct] >= 0.8
#     "excellent"
#   elsif p_stat[:avg_rating] >= 3.5 && p_stat[:verified_pct] >= 0.6
#     "good"
#   else
#     "concerning"
#   end
# end
# pp product_review_health


# 8
sales_data = [
  { rep_id: "A1", territory: "North", month: "Jan", sales: 15000, calls: 120, demos: 8 },
  { rep_id: "A1", territory: "North", month: "Feb", sales: 18000, calls: 140, demos: 12 },
  { rep_id: "B2", territory: "South", month: "Jan", sales: 22000, calls: 100, demos: 15 },
  { rep_id: "B2", territory: "South", month: "Feb", sales: 25000, calls: 110, demos: 18 },
  { rep_id: "C3", territory: "East", month: "Jan", sales: 8000, calls: 200, demos: 5 },
  { rep_id: "C3", territory: "East", month: "Feb", sales: 12000, calls: 180, demos: 8 },
  { rep_id: "D4", territory: "West", month: "Jan", sales: 30000, calls: 80, demos: 20 },
  { rep_id: "D4", territory: "West", month: "Feb", sales: 35000, calls: 90, demos: 25 }
]

rep_sales_data = sales_data.group_by{|s| s[:rep_id]}

sales_stats = rep_sales_data.transform_values do |sales|
  sales_per_call = (sales.sum{|s| s[:sales]} / sales.sum{|s| s[:calls]}.to_f).round(2)
  demo_conversion = (sales.sum{|s| s[:demos]} / sales.sum{|s| s[:calls]}.to_f).round(2)
  {sales_per_call:, demo_conversion:}
end

efficency_sales = sales_data.group_by do |sale|
  id = sale[:rep_id]
  stat = sales_stats[id]

  binding.pry

  if stat[:sales_per_call] >= 200 && stat[:demo_conversion] >= 0.15
    "high_performer"
  elsif stat[:sales_per_call] >= 150 && stat[:demo_conversion] >= 0.10
    "solid_performer"
  else
    "needs_improvement"
  end
end

pp efficency_sales