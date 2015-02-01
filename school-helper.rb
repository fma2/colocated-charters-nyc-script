class School <
	Struct.new(	:ATS_System_Code,
		:Location_Code,
		:Location_Name,
		:Managed_By_Name,
		:Location_Type_Description,
		:Location_Category_Description,
		:Grades,
		:Grades_Final,
		:Open_Date,
		:Status_Description,
		:Building_Code,
		:Primary_Address,
		:City,
		:State_Code,
		:Zip,
		:Geographical_District_Code,
		:Administrative_District_Code,
		:Administrative_District_Location_Code,
		:Administrative_District_Name,
		:Same_Address_As_Another_School
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