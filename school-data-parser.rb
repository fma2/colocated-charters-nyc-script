require 'csv'
load 'all-colocated-script.rb'
load 'colocated-charters-script.rb'
load 'colocated-buildings-list-script.rb'
load 'school-helper.rb'

def open_csv(title)
	CSV.open(title, "a+")
end

# RUN PARSER
all_schools_csv = "csv/lcgms-school-data-edited-aug13.csv"

# create array of school objects with all schools from original csv
all_schools_ary = create_school_objects_ary(all_schools_csv)

# open csv for schools with same address
schools_with_same_address = open_csv("csv/schools-with-same-address.csv")

# if csv is empty, add schools with same address to csv, 
# uses array of school objects from original csv
if schools_with_same_address.count == 0
	create_csv_with_same_address_schools(all_schools_ary, schools_with_same_address)
end

# create array of hashes where key is address, and value is array of schools with that address
schools_hsh = group_schools_with_same_address("csv/schools-with-same-address.csv")

# uses schools_hsh to create an array of hashes of buildings with charter schools
colocated_charters_ary = create_colocated_schools_ary(schools_hsh)

# uses colocated charters ary to add these schools to csv
colocated_charters_csv = open_csv("csv/colocated-charters-and-schools.csv")
if colocated_charters_csv.count == 0
	create_colocated_charters_csv(colocated_charters_ary,colocated_charters_csv) 
end

# uses colocated charters ary to add buildings to csv
buildings_with_colocated = open_csv("csv/colocated_buildings.csv")
if buildings_with_colocated.count == 0
	create_colocated_buildings_list(colocated_charters_ary, buildings_with_colocated)
end

puts colocated_charters_ary
puts colocated_charters_ary.count
##prints array of hashes of colocated school buildings with charter