class EntityController < ApplicationController
  def create
    # TODO: error handling

    s = Sentence.find(params[:id])

    s.entities.create(text: params[:text], entity_type: params[:type])

    redirect_to sentence_path(s)
  end
end
