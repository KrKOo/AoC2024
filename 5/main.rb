file = File.open("input.txt")
file_data = file.read.split(/\n\n/)
$rules = file_data[0].split(/\n/).map {|r| r.split(/\|/).map(&:to_i)}
$updates = file_data[1].split(/\n/).map {|u| u.split(/,/).map(&:to_i)}

def is_before(arr, a, b)
  idxa = arr.index(a)
  idxb = arr.index(b)
  return idxa == nil || idxb == nil ? true : idxa < idxb
end

def sort_by_page_rules(arr)
  arr.sort {|a,b| $rules.find { |r| r[0] == a && r[1] == b } ? -1 : 1} 
end

def satisfies_rules(update)
  $rules.map {|rule| is_before(update, rule[0], rule[1])}.all?
end

res1 = $updates.map {|update| satisfies_rules(update) ? sort_by_page_rules(update)[update.length/2] : 0}.sum()
res2 = $updates.map {|update| !satisfies_rules(update) ? sort_by_page_rules(update)[update.length/2] : 0}.sum()

puts "#{res1}\n" # Task 1
puts "#{res2}\n" # Task 2
