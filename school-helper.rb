class School <
	Struct.new(	:ats_system_code,
							:location_code,
							:location_name,
							:managed_by_name,
							:location_type_description,
							:location_category_description,
							:grades,
							:grades_final,
							:open_date,
							:status_description,
							:building_code,
							:primary_address,
							:city,
							:state_code,
							:zip,
							:geographical_district_code,
							:administrative_district_code,
							:administrative_district_location_code,
							:administrative_district_name,
							:same_address_as_another_school     
						)
end

def create_school_objects_ary(csv)
	all_schools = Array.new
	f = File.open(csv, "r")
	# loop through each record in the csv file, adding each record to our array.
	f.each_line { |line|
	  # each line has fields separated by commas, so split those fields
	  fields = line.split(',')
	  s = School.new
		s.ats_system_code = fields[0]
		s.location_code = fields[1]
		s.location_name = fields[2]
		s.managed_by_name = fields[3]
		s.location_type_description = fields[4]
		s.location_category_description = fields[5]
		s.grades = fields[6]
		s.grades_final = fields[7]
		s.open_date = fields[8]
		s.status_description = fields[9]
		s.building_code = fields[10]
		s.primary_address = fields[11]
		s.city = fields[12]
		s.state_code = fields[13]
		s.zip = fields[14]
		s.geographical_district_code = fields[15]
		s.administrative_district_code = fields[16]
		s.administrative_district_location_code = fields[17]
		s.administrative_district_name = fields[18].chomp
	  all_schools.push(s)
	}
	all_schools
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