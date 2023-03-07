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

      expect(s.entities.count).to equal(2)
      expect(s.entities.map(&:text)).to match_array([e1.text, e2.text])
    end
  end
end
