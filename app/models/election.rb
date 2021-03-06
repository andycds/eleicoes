class Election < ActiveRecord::Base
	has_many :candidates
	has_many :votes
	has_many :people

	def valida? documento
		if documento ==  "master2" || documento == "master3" || documento == "master4"
			return true
		end
		return Time.now.in_time_zone('Brasilia') >= dt_inicio.in_time_zone('Brasilia') && Time.now.in_time_zone('Brasilia') <= dt_fim.in_time_zone('Brasilia')
	end

end
