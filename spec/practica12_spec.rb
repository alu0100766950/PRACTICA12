require "arbol"
require 'spec_helper'

describe Naranjero do
	before :each do
		@arbol = Naranjero.new
		@mutex = Mutex.new
		@recurso = ConditionVariable.new

		describe "A ver si hace algo" do
			it "Hace algo" do
				crecer = Thread.new do
					loop do
						sleep rand 0
						if arbol.edad < arbol.muerte
							arbol.uno_mas
							puts "Arbol creciendo"
						else 
							puts "Arbol muerto"
							break
						end
					end
				end

				recolector = Thread.new do
					loop do
						sleep (rand 0) + 2
						while arbol.naranjas > 0
							arbol.recolectar_una
							puts "Naranja recogida"
						end
						if(arbol.naranjas_recogidas >= arbol.naranjas_producidas)
							break
						end
					end
				end
				crecer.join
				recolector.join
				arbol.naranjas_recogidas.should eq(arbol.naranjas_producidas)
			end
		end
	end
end