require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe "#create" do
    it "creates an entity model" do
      s = Sentence.create!(text: "i have a thing")
      e = Entity.create!(text: "thing", entity_type: "MONEY", sentence: s)

      expect(s.id).not_to be_nil
    end
  end
end
