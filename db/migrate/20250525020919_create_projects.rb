class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.integer :status
      t.string :name

      t.timestamps
    end
  end
end
