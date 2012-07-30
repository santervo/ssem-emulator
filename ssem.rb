require './lib/ssem'

unless ARGV.length == 1
  puts "USAGE: ssem <source file>"
  exit
end

file_name = ARGV[0]

mem = Array.new
file = File.new(file_name, "r")
while(line = file.gets)
  mem << line.split(" ")[0].to_i(16)
end

ssem = Ssem.new(mem)
puts "Ssem itialized with memory contents:"
p ssem.mem

ssem.run

puts "\nProgram was executed successfully."
print "Memory contents: "
p ssem.mem
puts "IR: " + ssem.ir.to_s
puts "PC: " + ssem.pc.to_s
puts "ACC: " + ssem.acc.to_s
