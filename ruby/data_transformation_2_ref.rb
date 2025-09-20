# API RESPONSE
# {
#   "orders" => [
#     {
#       "id" => "ORD-001",
#       "customer" => { "id" => 501, "name" => "TechCorp Inc", "tier" => "enterprise" },
#       "items" => [
#         { "product_id" => "LAPTOP-X1", "name" => "Gaming Laptop", "category" => "electronics", "price" => 1299.99, "quantity" => 2 },
#         { "product_id" => "MOUSE-A2", "name" => "Wireless Mouse", "category" => "electronics", "price" => 49.99, "quantity" => 5 }
#       ],
#       "order_date" => "2025-01-15"
#     },
#     {
#       "id" => "ORD-002", 
#       "customer" => { "id" => 502, "name" => "StartupXYZ", "tier" => "standard" },
#       "items" => [
#         { "product_id" => "DESK-B1", "name" => "Standing Desk", "category" => "furniture", "price" => 599.99, "quantity" => 3 },
#         { "product_id" => "CHAIR-C1", "name" => "Ergonomic Chair", "category" => "furniture", "price" => 299.99, "quantity" => 2 }
#       ],
#       "order_date" => "2025-01-16"
#     },
#     # ... more orders
#   ]
# }
# 
# EXAMPLE OUTPUT
# 
# {
#   "electronics" => {
#     "total_revenue" => 4149.89,
#     "total_units" => 28,
#     "product_count" => 4,
#     "products" => {
#       "LAPTOP-X1" => {
#         "name" => "Gaming Laptop",
#         "total_revenue" => 3899.97,
#         "units_sold" => 3,
#         "avg_order_size" => 1.5,
#         "top_customers" => [
#           { "customer_id" => 501, "customer_name" => "TechCorp Inc", "total_purchased" => 3899.97, "units" => 3 }
#         ]
#       },
#       "MOUSE-A2" => {
#         "name" => "Wireless Mouse", 
#         "total_revenue" => 749.85,
#         "units_sold" => 15,
#         "avg_order_size" => 7.5,
#         "top_customers" => [
#           { "customer_id" => 504, "customer_name" => "Remote Team", "total_purchased" => 499.90, "units" => 10 },
#           { "customer_id" => 501, "customer_name" => "TechCorp Inc", "total_purchased" => 249.95, "units" => 5 }
#         ]
#       },
#       # ... more products
#     }
#   },
#   "furniture" => {
#     "total_revenue" => 3179.91,
#     "total_units" => 13,
#     "product_count" => 3,
#     "products" => {
#       # ... furniture products
#     }
#   }
# }