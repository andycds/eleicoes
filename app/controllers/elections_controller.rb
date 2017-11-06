class ElectionsController < ApplicationController
	def resultado
		@elections = Election.all
		@votes = Array.new
		@elections.each do |el|
			listaVoto = Vote.find_by_sql("select * from votes where election_id = #{el.id}")
			@votes[el.id] = listaVoto unless listaVoto.size == 0
		end
	end
end
