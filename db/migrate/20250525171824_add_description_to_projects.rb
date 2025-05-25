class AddDescriptionToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :description, :text, null: true, default: nil
    
    change_column_default :projects, :description, from: nil, to: ""
    change_column_null :projects, :description, false, ""
  end
end
