class CreateChangeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :change_logs do |t|
      t.references :recordable, polymorphic: true, null: false
      t.jsonb :changed_data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
