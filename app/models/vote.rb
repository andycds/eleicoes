class Vote < ActiveRecord::Base
	belongs_to :election
	belongs_to :candidate
	belongs_to :person
end
