# first run:
# dotfile in dir with list of all files and 0
# pick random file, open it, increment to 1 in file
# in commandline, 'o' to open next. 'n' to quit

# second run:
# check for new files in repo?
# # "hi: x unread files, x read files. Start? y/n"
# open file. from the 0 marked ones, 
# pick random file, open it, increment to 1 in file
# in commandline, 'n' to open next. 'q' to quit


if ARGV.size != 1
	puts "Usage: ruby redo.rb <path to root dir>"
	exit
end

puts "Warning: if you quit with Ctrl-C instead of with 'q' your progress will not be saved"

root_dir = ARGV[0]
data_file = root_dir + "/.readminder"

require 'csv'
unless File.exist?(data_file)
	f = File.new(data_file, 'w') 
	files_in_root_dir = Dir.entries(root_dir).select {|f| f != '.' && f != '..' && !(f.include?('readminder'))}
	CSV.open(data_file, "wb") do |csv|
	  files_in_root_dir.each {|file|
	  	csv << [file, '0']
	  }
	end
	f.close
end

data = CSV.read(data_file)

# p data
random_pair = data[rand(data.size)]
puts "random pair is: #{random_pair}"
data.delete(random_pair)
new_pair = [random_pair.first, random_pair.last.to_i + 1]
data << new_pair

puts data

# pick random
# write '1' to data structure
# when 'o' pick and open next

# when q, write data to file. 