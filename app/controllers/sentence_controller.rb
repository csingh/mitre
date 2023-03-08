class SentenceController < ApplicationController
  def index
    @sentences = Sentence.all
    @tagged_sentences = @sentences.map(&:tagged_text)
  end

  def show

  end
end
