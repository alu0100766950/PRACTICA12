require 'arbol'
require 'spec_helper'

describe Naranjero do
	before :each do
		@arbol = Naranjero.new
		@mutex = Mutex.new
		@recurso = ConditionVariable.new
	end
	describe "A ver si hace algo" do
		it "Hace algo" do
			crecer = Thread.new do
				loop do
					if @arbol.edad < @arbol.muerte
						@arbol.uno_mas
						print " "
						if(@arbol.edad > 3)
							@mutex.lock
							@recurso.signal
							@mutex.unlock
						end
					else
#						print "Muerto\n"
						break
					end
				end
			end
			recolector = Thread.new do
				loop do
					@mutex.lock
					@recurso.wait(@mutex)
					while @arbol.naranjas > 0
						@arbol.recolectar_una
#						print "Naranja recogida\n"
					end
					if (@arbol.naranjas_recogidas >= @arbol.naranjas_producidas) && (@arbol.edad >= @arbol.muerte)
						break
					end
					@mutex.unlock
				end
			end
			crecer.join
			recolector.join
			@arbol.naranjas_recogidas.should eq(@arbol.naranjas_producidas)
		end
	end
end