class Election < ActiveRecord::Base
	has_many :candidates
	has_many :votes
	has_many :people

	def valida?
		return Time.now.in_time_zone('Brasilia') >= dt_inicio.in_time_zone('Brasilia') && Time.now.in_time_zone('Brasilia') <= dt_fim.in_time_zone('Brasilia')
	end
end
