require 'csv'
load 'all-colocated-script.rb'
load 'colocated-charters-script.rb'
load 'school-helper.rb'

def open_csv(title)
	CSV.open(title, "a+")
end

#PARSER
all_schools_csv = "csv/lcgms-school-data-edited-aug13.csv"

create_school_objects_ary(all_schools_csv)

schools_with_same_address = open_csv("csv/schools-with-same-address.csv")
if schools_with_same_address.count == 0
	create_csv_with_same_address_schools(create_school_objects_ary(all_schools_csv), schools_with_same_address)
end

schools_hsh = group_schools_with_same_address("csv/schools-with-same-address.csv")
puts create_colocated_schools_ary(schools_hsh) 
##prints array of hashes of colocated school buildings with charter