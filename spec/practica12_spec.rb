require "arbol"

describe Naranjero do
	before :each do
		@arbol = Naranjero.new
		@mutex = Mutex.new
		@recurso = ConditionVariable.new

		describe "A ver si hace algo" do
			it "Hace algo" do
				recolector = Thread.new {
					@mutex.syncronize {
					puts a
					a = "NoNaranja"
					@recurso.wait(@mutex)
					while(@arbol.naranjas > 0)
						@arbol.recolectar_una
					end
					a = "NaranjaR"
					puts a
					}
				}
				crecer = Thread.new {
					@mutex.syncronize {
					@arbol.uno_mas
					a = "Pasando"
					puts a
					if(@arbol.naranjas > 0)
						@recurso.signal
						puts "Hay naranjas"
						a = "Naranja"
						puts a
					end
					}
				}
				a.should eq("Naranja")
			end
		end
	end
end