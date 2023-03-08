module SentenceHelper
	def get_colour
		# TODO: might want to have consistent colour for multiple tags of the same entity?
		# Idea: Could actually assign an entity to a specified colour, or random colour on creation. Save that colour to the DB and look it up here in the helper to assign it

		# CSS colours to choose from
		%W{pink aqua yellow lime aquamarine beige coral gold lightseagreen}.sample
	end

	def render_tagged_text(text, type)
		html = "<span class='entity' style='background-color: #{get_colour}'>#{text} <strong>#{type}</strong></span>"
		html.html_safe
	end
end
