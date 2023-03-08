require 'rails_helper'

RSpec.describe Sentence, type: :model do
  describe "#create" do
    it "creates a sentence model" do
      s = Sentence.create!(text: "my sentence")

      expect(s.id).not_to be_nil
    end

    it "creates a sentence with entities" do
      s = Sentence.create!(text: "my sentence with entities")
      e1 = Entity.create!(text: "one", entity_type: "MONEY", sentence: s)
      e2 = Entity.create!(text: "two", entity_type: "GPE", sentence: s)

      expect(s.entities.count).to eq(2)
      expect(s.entities.map(&:text)).to match_array([e1.text, e2.text])
    end
  end

  describe "#match_entities" do
    it "returns matched entities and characters to highlight" do
      s = Sentence.create!(text: "One two three one")
      e1 = Entity.create!(text: "one", entity_type: "MONEY", sentence: s)
      e2 = Entity.create!(text: "two", entity_type: "GPE", sentence: s)

      matched_entities = s.match_entities
      
      expect(matched_entities.length).to eq(3)
      expect(matched_entities[0]).to eq(first: 0, last: 2, text: "One", type: "MONEY")
      expect(matched_entities[1]).to eq(first: 14, last: 16, text: "one", type: "MONEY")
      expect(matched_entities[2]).to eq(first: 4, last: 6, text: "two", type: "GPE")
    end
  end
end
