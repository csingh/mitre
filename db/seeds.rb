# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


seed_data = [
	{
		sentence: "Apple is looking at buying U.K. startup for $1 billion.",
		entities: [
			{ text: "Apple", type: "ORG" },
			{ text: "U.K.", type: "GPE"},
			{ text: "$1 billion", type: "MONEY" }
		]
	},
	{
		sentence: "Regional funds with exposure to United States and outperform equity market over 3 year",
		entities: [
			{ text: "Regional funds", type: "THEME"},
			{ text: "United States", type: "GPE"},
			{ text: "equity market", type: "THEME"},
			{ text: "3 year", type: "TIME" }
		]
	}
]

seed_data.each do |data|
	s = Sentence.create!(text: data[:sentence])
	data[:entities].each do |e|
		s.entities.create!(text: e[:text], entity_type: e[:type])
	end
end
