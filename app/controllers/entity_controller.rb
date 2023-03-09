class EntityController < ApplicationController
  def create
    s = Sentence.find(params[:id])

    text = params[:text].strip
    type = params[:type].strip

    if text.blank? || type.blank?
      redirect_to controller: 'sentence', action: 'show', id: s.id, error: "Entity text and Entity type cannot be blank"
      return
    end

    s.entities.create(text: params[:text], entity_type: params[:type])

    redirect_to controller: 'sentence', action: 'show', id: s.id
  end
end
