class Candidate < ActiveRecord::Base
	attr_accessor :vote_for_me
	belongs_to :election
end
