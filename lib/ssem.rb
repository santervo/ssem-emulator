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


