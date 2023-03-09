class SentenceController < ApplicationController
  def index
    @sentences = Sentence.all
    @tagged_sentences = @sentences.map(&:tagged_text)
  end

  def show
    @sentence = Sentence.find(params[:id])
    @tagged_sentence = @sentence.tagged_text
    @error = params[:error]
  end
end
