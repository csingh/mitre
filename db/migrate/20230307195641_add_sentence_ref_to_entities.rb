class AddSentenceRefToEntities < ActiveRecord::Migration[7.0]
  def change
    add_reference(:entities, :sentences, foreign_key: true, null: false)
  end
end
