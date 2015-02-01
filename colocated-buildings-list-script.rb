def create_colocated_buildings_list(schools_hsh, csv)
	schools_hsh.each {|x| x.keys.each {|y| csv << [y]}}
end