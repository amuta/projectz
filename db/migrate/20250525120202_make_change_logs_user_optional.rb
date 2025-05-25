class MakeChangeLogsUserOptional < ActiveRecord::Migration[8.0]
  def change
    change_column_null :change_logs, :user_id, true
  end
end
