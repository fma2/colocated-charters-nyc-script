require 'csv'
load 'school.rb'

def create_school_objects_ary(csv)
	all_schools = Array.new
	f = File.open(csv, "r")
	# loop through each record in the csv file, adding each record to our array.
	f.each_line { |line|
	  # each line has fields separated by commas, so split those fields
	  fields = line.split(',')
	  s = School.new
		s.ATS_System_Code = fields[0]
		s.Location_Code = fields[1]
		s.Location_Name = fields[2]
		s.Managed_By_Name = fields[3]
		s.Location_Type_Description = fields[4]
		s.Location_Category_Description = fields[5]
		s.Grades = fields[6]
		s.Grades_Final = fields[7]
		s.Open_Date = fields[8]
		s.Status_Description = fields[9]
		s.Building_Code = fields[10]
		s.Primary_Address = fields[11]
		s.City = fields[12]
		s.State_Code = fields[13]
		s.Zip = fields[14]
		s.Geographical_District_Code = fields[15]
		s.Administrative_District_Code = fields[16]
		s.Administrative_District_Location_Code = fields[17]
		s.Administrative_District_Name = fields[18].chomp
	  all_schools.push(s)
	}
end

def create_csv_with_same_address_schools(schools)
	all_schools.each do |school|
		address = school.Primary_Address
		matched_item = all_schools.find { | item | item.Primary_Address == address && item.ATS_System_Code != school.ATS_System_Code }
		school.Same_Address_As_Another_School = true;
		if matched_item != nil
			schools_with_same_address << school
		end
	end
end

def group_schools_with_same_address(csv_title)
	same_address_schoolsHsh = Hash.new
	schools = CSV.read(csv_title)
	schools.each do |school|
		same_address_schoolsHsh[school[11]] = []
	end
	schools.each do |school|
		same_address_schoolsHsh[school[11]] << school
	end
	same_address_schoolsHsh
end

def create_colocated_schools_ary(schools_hsh)
	colocated_addresses_w_charter = []
	charters_colocation = open_csv("colocated-charters-and-schools.csv")
	schools_hsh.each_pair do |k,v|
		charter_school = v.find { |x| x[3] == "Charter"}
		if charter_school != nil
			colocated_addresses_w_charter << {k => v}
			# v.each {|x| charters_colocation << x}
		end
	end
	colocated_addresses_w_charter
end

def open_csv(title)
	CSV.open(title, "a+")
end


#RUN SCRIPT
all_schools_csv = "lcgms-school-data-edited-aug13.csv"

create_school_objects_ary(all_schools_csv)

schools_with_same_address = open_csv("schools-with-same-address.csv")
if schools_with_same_address.count == 0
	create_csv_with_same_address_schools(all_schools)
end

schools_hsh = group_schools_with_same_address("schools-with-same-address.csv")
puts create_colocated_schools_ary(schools_hsh)