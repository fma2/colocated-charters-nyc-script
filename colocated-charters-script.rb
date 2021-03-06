def create_colocated_schools_ary(schools_hsh)
	colocated_addresses_w_charter = []
	charters_colocation = open_csv("csv/colocated-charters-and-schools.csv")
	schools_hsh.each_pair do |k,v|
		charter_school = v.find { |x| x[3] == "Charter"}
		if charter_school != nil
			colocated_addresses_w_charter << {k => v}
		end
	end
	colocated_addresses_w_charter
end

def create_colocated_charters_csv(schools_hsh, csv)
	schools_hsh.each {|x| x.values.each { |y| y.each {|z| csv << z} }}
end