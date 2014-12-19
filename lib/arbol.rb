require 'thread'

class Naranjero
	attr_reader :altura, :edad, :naranjas, :muerte, :naranjas_recogidas, :naranjas_producidas
	attr_writer :altura, :edad, :naranjas, :muerte, :naranjas_recogidas, :naranjas_producidas

	def initialize
		@altura = 0
		@edad = 0
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