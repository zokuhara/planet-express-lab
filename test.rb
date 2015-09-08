require 'csv'
require 'erb'

deliveries = []
CSV.foreach("./planet_express_logs.csv", headers: true) do |row|
  deliveries << row.to_hash
end

bonus_multiplier = 0.10
employees = %w(Fry Amy Bender Leela)
planets = %w(Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto)
# second_table_head = ["Employee", "Number of Deliveries", "Bonus Pay"]
pilot_destinations = {}
pilot_destinations["Fry"] = "Earth"
pilot_destinations["Amy"] = "Mars"
pilot_destinations["Bender"] = "Uranus"
pilot_destinations["Leela"] = %w(Mercury Moon Jupiter Saturn Pluto)

# fry_deliveries = deliveries.select{ |delivery| pilot_destinations["Fry"].include? delivery["Destination"]}
# fry_mission_count = fry_deliveries.count
# fry_receipts = fry_deliveries.map { |delivery| delivery["Money"].to_i}
# fry_bonus = fry_receipts.reduce(:+) * bonus_multiplier


planet_deliveries = []
planets.each do |planet|
  planet_deliveries << deliveries.select do |delivery|
    planet.include? delivery["Destination"]
  end
end


planet_receipts = []
planet_deliveries.each do |planet_delivery|
  planet_receipts << planet_delivery.map do |delivery|
    delivery["Money"].to_i
  end
end
#
#
# pilot_bonus = []
# pilot_receipts.each do |receipt|
#   pilot_bonus << receipt.reduce(:+) * bonus_multiplier
# end

puts planet_receipts
