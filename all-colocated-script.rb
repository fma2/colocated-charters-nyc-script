def create_csv_with_same_address_schools(schools, csv)
	schools.each do |school|
		address = school.Primary_Address
		matched_item = schools.find { | item | item.Primary_Address == address && item.ATS_System_Code != school.ATS_System_Code }
		school.Same_Address_As_Another_School = true;
		if matched_item != nil
			csv << school
		end
	end
end