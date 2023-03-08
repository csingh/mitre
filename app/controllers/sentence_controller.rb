class SentenceController < ApplicationController
  def index
    sentences = Sentence.all
    @tagged_sentences = sentences.map(&:tagged_text)

    puts "@tagged_sentences:"
    puts @tagged_sentences
  end

  def show

  end
end
