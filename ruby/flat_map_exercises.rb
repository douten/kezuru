# 1
# pp [[1, 2], [3, 4], [5, 6]].flat_map{|arr| arr}
# pp [[1, 2], [3, 4], [5, 6]].flat_map(&:iteself)
# pp [1, 2, 3].flat_map{|n| [n, (n*2)]}

# 2
# a = ["cat", "elephant", "dog", "butterfly", "ant"].flat_map do |word|
#   word.length > 3 ? word.split("") : []
#   # word.chars
# end
# pp a

# 3
# students = [
#   { name: "Alice", grades: [85, 92] },
#   { name: "Bob", grades: [78, 85, 90] },
#   { name: "Carol", grades: [95] }
# ]

# 4
# grades = students.flat_map do |student|
#   student[:grades]
# end
# pp grades

# 5
# data = ["1,2", "3,4,5", "6"]
# output = data.flat_map do |str|
#   # str.split(",").map{|s| s.to_i}
#   str.split(",").map(&:to_i)
# end
# pp output

# 6
# ranges = [1..3, 5..6, 8..10]
# output = ranges.flat_map do |range|
#   range.filter(&:even?)
# end
# pp output