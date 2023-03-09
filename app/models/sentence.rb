class Sentence < ApplicationRecord
	has_many :entities

	# Returns a list of entity matches for the sentence, including the characters to highlight
	# Meant to be a helper, and not to be called directly
	def _match_entities
		# TODO: maybe handle entity highlight collisions
	    # E.g. if there are 2 entities with text: "Apple" and "Apple Org", how to figure out which is applied first
	    # Ideas:
	    # 	- When matching an entity, check oif any other entites contain that entity as a substring. If yes, ignore tihs substring entity and continue checks
	    # 	- Or when actually creating Entities, we could assign it some sort of priority number to help resolve conflicts

	    all_matches = []

		self.entities.each do |e|
			# Not the most intuitive, but a nice way to get MatchData for all string matches
			escaped_text = Regexp.escape(e.text)
			matches = self.text.to_enum(:scan, /(?<=^| )#{escaped_text}(?=$| )/i).map { Regexp.last_match }

			matches.each do |m|
				first = m.begin(0)
				last = m.end(0) - 1
				all_matches << {
					first: first,
					last: last,
					text: self.text[first..last],
					type: e.entity_type,
				}
			end
		end

		all_matches
	end

	# Construct a list representation of the sentence, separating out tagged and untagged portions
	def tagged_text
		entity_matches = self._match_entities.sort_by { |ent| ent[:first] }
		tagged_sentence = []

		# i = sentence position
		i = 0
		while i < self.text.length
			if entity_matches.empty?
				tagged_sentence << {
					tagged: false,
					text: self.text[i..-1]
				}
				break
			end

			next_entity = entity_matches.first
			if i == next_entity[:first]
				# If we're at a currently matched entity
				tagged_sentence << {
					tagged: true,
					text: next_entity[:text],
					type: next_entity[:type],
				}
				i = next_entity[:last] + 1
				entity_matches.shift
			else
				# Else untagged text until the next entity
				tagged_sentence << {
					tagged: false,
					text: self.text[i..next_entity[:first]-1]
				}
				i = next_entity[:first]
			end

		end

		tagged_sentence
	end
end
