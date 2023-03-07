class AddSentenceRefToEntities < ActiveRecord::Migration[7.0]
  def change
    change_table(:entities) do |t|
      t.column :text, :text, null: false
      t.column :entity_type, :string, null: false # type is a reserved column name in rails
      t.belongs_to :sentence, foreign_key: true, null: false
    end
  end
end
