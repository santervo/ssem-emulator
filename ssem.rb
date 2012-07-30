class Ssem
  JMP = 0
  JRP = 1
  LDN = 2
  STO = 3
  SUB = 4
  CMP = 6
  STP = 7

  attr :mem
  attr :acc
  attr :ir
  attr :pc

  def initialize(mem)
    @mem = mem
    @acc = 0
    @ir = 0
    @pc = 0
  end

  def run
    until @stop
      self.fetch
      self.execute
      self.increment
    end
  end

  def fetch
    @ir = @mem[@pc]
  end

  def execute
    instruction = (@ir >> 12) & 7
    address = @ir & 0xfff
    case instruction
    when LDN
      @acc = -@mem[address]
    when STO
      @mem[address] = @acc
    when SUB
      @acc -= @mem[address]
    when STP
      @stop = true
    else
      raise Exception.new("Unknown instuction code: #{instruction}")
    end
  end

  def increment
    @pc += 1
  end

end

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
