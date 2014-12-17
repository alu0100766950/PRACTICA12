require 'thread'
require 'spec_helper'

class Naranjero
	attr_reader :altura, :edad, :naranjas
	attr_writer :altura, :edad, :naranjas
	def initialize
		@altura = 0
		@edad = 1
		@naranjas = 0
		@muerte = 10
		@probabilidad_naranjas = 0
	end
	def uno_mas
		if(@edad < @muerte)
			@edad = @edad + 1
			@altura = @altura + 0.25
			if(@edad > 3) then
				produce_naranjas
			@probabilidad_naranjas = @probabilidad_naranjas + 3
			end
		end
	end
	def produce_naranjas
		num = rand(10 + @probabilidad_naranjas) + (10 + @probabilidad_naranjas)
		@naranjas = @naranjas + num
	end
	def recolectar_una
		@naranjas = @naranjas - 1
	end
end

arbol = Naranjero.new
mutex = Mutex.new
recurso = ConditionVariable.new
recolector = Thread.new {
mutex.syncronize {
puts "Esperando por naranja"
recurso.wait(mutex)
while(arbol.naranjas > 0)
arbol.recolectar_una
end
puts "Naranja recogida"
}
}
crecer = Thread.new {
mutex.syncronize {
arbol.uno_mas
puts "Anno pasado"
if(arbol.naranjas > 0)
recurso.signal
puts "Hay naranjas"
end
}
}
