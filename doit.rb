git_dir = ARGV[0] || "../../bt/gateway"
# needs to be able to exclude dirs

viewed_files_store = ARGV[1] || "viewed_files.txt"

if !File.file?(viewed_files_store)
	f = File.new(viewed_files_store, "w")
	f.close
end
f = File.open(viewed_files_store, "r") 
viewed_files = f.read
f.close

# p viewed_files

def procdir(dir)
  Dir[ File.join(dir, '**', '*') ].reject { |p| File.directory? p }
end

file_list = procdir(git_dir)

# p file_list

clean_file_list = file_list.map {|filename| filename.gsub(git_dir, '')}

files = viewed_files.split("\n").map{|line| line.split(",").first}
File.open(viewed_files_store, 'a') do |f|
	clean_file_list.each {|filename|
		if !files.include?(filename)
			puts "writing new file to tracked files: #{filename}"
			f.puts "#{filename},0"
		end
	}
  
end


# grab lines from store
# add any new lines to store as 0
# open a line from the store as a file
# mark that line as a 1






# what if new files are added?