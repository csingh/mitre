require 'rails_helper'

RSpec.describe Sentence, type: :model do
  describe "#create" do
    it "creates a sentence model" do
      text = "my sentence"

      s = Sentence.create!(text: text)

      expect(s.id).not_to be_nil
    end
  end
end
