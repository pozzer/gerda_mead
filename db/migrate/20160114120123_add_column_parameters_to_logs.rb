class AddColumnParametersToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :parameters, :text
  end
end
