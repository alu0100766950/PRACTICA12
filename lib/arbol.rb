require 'thread'

class Naranjero
	attr_reader :altura, :edad, :naranjas, :muerte, :naranjas_recogidas, :naranjas_producidas
	attr_writer :altura, :edad, :naranjas, :muerte, :naranjas_recogidas, :naranjas_producidas

	def initialize
		@altura = 0
		@edad = 1
		@naranjas = 0
		@muerte = 10
		@probabilidad_naranjas = 0
		@naranjas_recogidas = 0
		@naranjas_producidas = 0
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
		@naranjas_producidas = @naranjas_producidas + num
	end
	def recolectar_una
		@naranjas = @naranjas - 1
		@naranjas_recogidas = @naranjas_recogidas + 1
	end
end

arbol = Naranjero.new
mutex = Mutex.new
mutex = 0
recurso = ConditionVariable.new

crecer = Thread.new do
	loop do
		if arbol.edad < arbol.muerte
			arbol.uno_mas
			puts "Creciendo"
			mutex = mutex + 1
		else
			puts "Muerto"
			mutex = mutex + 1
			break
		end
	end
end

recolector = Thread.new do
	loop do
		mutex = mutex - 1
		while arbol.naranjas > 0
			arbol.recolectar_una
			puts "Naranja recogida"
		end
		if (arbol.naranjas_recogidas >= arbol.naranjas_producidas) && (arbol.edad >= arbol.muerte)
			break
		end
	end
end

crecer.join
recolector.join
puts "Han sido recogidas #{arbol.naranjas_recogidas} naranjas de #{arbol.naranjas_producidas}"