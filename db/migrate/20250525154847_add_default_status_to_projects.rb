class AddDefaultStatusToProjects < ActiveRecord::Migration[8.0]
  def change
    change_column_default :projects, :status, from: nil, to: 0
    change_column_null    :projects, :status, false, 0
  end
end
