class Entity < ApplicationRecord
	belongs_to :sentence

	# TODO: validate Entity to be unique across text field + sentence_id?
end
