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

  describe "#_match_entities" do
    it "returns matched entities and characters to highlight" do
      s = Sentence.create!(text: "One two three one $1billy test")
      Entity.create!(text: "one", entity_type: "MONEY", sentence: s)
      Entity.create!(text: "two", entity_type: "GPE", sentence: s)
      Entity.create!(text: "$1billy", entity_type: "$$$", sentence: s)

      matched_entities = s._match_entities
      
      expect(matched_entities.length).to eq(4)
      expect(matched_entities[0]).to eq(first: 0, last: 2, text: "One", type: "MONEY")
      expect(matched_entities[1]).to eq(first: 14, last: 16, text: "one", type: "MONEY")
      expect(matched_entities[2]).to eq(first: 4, last: 6, text: "two", type: "GPE")
      expect(matched_entities[3]).to eq(first: 18, last: 24, text: "$1billy", type: "$$$")
    end

    it "matches only whole word matches" do
      s = Sentence.create!(text: "greenapple Apple")
      e1 = Entity.create!(text: "apple", entity_type: "APPL", sentence: s)

      matched_entities = s._match_entities
      
      expect(matched_entities.length).to eq(1)
      expect(matched_entities[0]).to eq(first: 11, last: 15, text: "Apple", type: "APPL")
    end
  end

  describe "#tagged_text" do
    it "should return the untagged text if no matched entities" do
      s = Sentence.create!(text: "One two three one")
      e1 = Entity.create!(text: "four", entity_type: "MONEY", sentence: s)

      tagged_text = s.tagged_text

      expect(tagged_text.length).to eq(1)
      expect(tagged_text.first[:text]).to eq(s.text)
    end

    it "should return tagged and untagged portions in order" do
      s = Sentence.create!(text: "One two three")
      e1 = Entity.create!(text: "one", entity_type: "MONEY", sentence: s)
      e2 = Entity.create!(text: "three", entity_type: "GPE", sentence: s)

      tagged_text = s.tagged_text

      expect(tagged_text.length).to eq(3)
      expect(tagged_text[0]).to eq(tagged: true, text: "One", type: "MONEY")
      expect(tagged_text[1]).to eq(tagged: false, text: " two ")
      expect(tagged_text[2]).to eq(tagged: true, text: "three", type: "GPE")
    end

    it "should return tagged and untagged portions in order even when entities are not" do
      s = Sentence.create!(text: "One two three")
      e2 = Entity.create!(text: "three", entity_type: "GPE", sentence: s)
      e1 = Entity.create!(text: "one", entity_type: "MONEY", sentence: s)

      tagged_text = s.tagged_text

      expect(tagged_text.length).to eq(3)
      expect(tagged_text[0]).to eq(tagged: true, text: "One", type: "MONEY")
      expect(tagged_text[1]).to eq(tagged: false, text: " two ")
      expect(tagged_text[2]).to eq(tagged: true, text: "three", type: "GPE")
    end
  end
end
