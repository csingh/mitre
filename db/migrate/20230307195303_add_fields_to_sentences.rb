class AddFieldsToSentences < ActiveRecord::Migration[7.0]
  def change
    change_table(:sentences) do |t|
      t.column :text, :text
    end
  end
end
