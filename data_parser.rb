require 'csv'
require 'erb'

deliveries = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  deliveries << row.to_hash
end

bonus_multiplier = 0.10
employees = %w(Fry Amy Bender Leela)
planets = %w(Mercury Venus Earth Moon Mars Jupiter Saturn Uranus Neptune Pluto)
second_table_head = ["Employee", "Deliveries", "Bonus Pay"]
third_table_head = ["Planet", "Total Deliveries"]
pilot_destinations = {}
pilot_destinations["Fry"] = "Earth"
pilot_destinations["Amy"] = "Mars"
pilot_destinations["Bender"] = "Uranus"
pilot_destinations["Leela"] = %w(Mercury Moon Jupiter Saturn Pluto)

income = deliveries.map { |delivery| delivery["Money"].to_i }
total_income = income.reduce(:+)

# ----Steps to automate------
# fry_deliveries = deliveries.select{ |delivery| pilot_destinations["Fry"].include? delivery["Destination"]}
# fry_mission_count = fry_deliveries.count
# fry_receipts = fry_deliveries.map { |delivery| delivery["Money"].to_i}
# fry_bonus = fry_receip

pilot_deliveries = []
employees.each do |employee|
  pilot_deliveries << deliveries.select do |delivery|
    pilot_destinations[employee].include? delivery["Destination"]
  end
end


pilot_receipts = []
pilot_deliveries.each do |pilot_delivery|
  pilot_receipts << pilot_delivery.map do |delivery|
    delivery["Money"].to_i
  end
end


pilot_bonus = []
pilot_receipts.each do |receipt|
  pilot_bonus << receipt.reduce(:+) * bonus_multiplier
end

planet_deliveries = []
planets.each do |planet|
  planet_deliveries << deliveries.select do |delivery|
    planet.include? delivery["Destination"]
  end
end

planet_totals = []
planet_deliveries.each do |planet_delivery|
  planet_totals << planet_delivery.map do |delivery|
    delivery["Money"].to_i
  end
end

planet_receipts = []
planet_totals.each do |planet|
  planet_receipts << planet.reduce(:+)
end

b = binding
template = File.read("./report.erb")
result = ERB.new(template).result(b)

# pilot_delivery_stats = [
#  {"name"=> "Fry", "trip_count"=«total» , "total_bonus"=> «total» }
#  {"name"=> "Amy", "trip_count"=«total» , "total_bonus"=> «total» }
#  ...
#]


File.open("./report.html", "wb") {|f| f << result}
