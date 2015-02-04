# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
barangay_list = [
	"Nazareth",
	"Carmen",
	"Lapasan"
]

services_list = [
	"Health & Beauty Care",
	"Business & Education",
	"Computer & Electronics",
	"Home & Gardener",
	"Vehicle & Auto"
]

barangay_list.each do |name|
  Barangay.create( barangay: name)
end

services_list.each do |name|
  Service.create( service: name)
end



category_list = [
	["Barber","Health & Beauty Care"],
	["Masseuse/Hilot","Health & Beauty Care"],
	["Manicurist/Pedicurist","Health & Beauty Care"],
	["Makeup Artist","Health & Beauty Care"],
	["Computer Repair","Computer & Electronics"],
	["Cellphone Repair/Unlock","Computer & Electronics"],
	["Radio Communication/Repair","Computer & Electronics"],
	["Auto Body Repair","Vehicle & Auto"],
	["Auto Mechanic","Vehicle & Auto"],
	["Car Aircon","Vehicle & Auto"]
]

category_list.each do |name, service|
  Category.create(name: name, service_id: Service.find_by(service: service).id)
end

=end

clearance_list = [
	"NBI",
	"Police Clearance",
	"Barangay Clearnce"
]


clearance_list.each do |name|
  Clearance.create(name: name)
end
