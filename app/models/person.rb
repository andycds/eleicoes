class Person < ActiveRecord::Base
	has_secure_password
	belongs_to :election

	def ja_votou?
		return Vote.find_by_person_id(self.id) != nil
	end
end
