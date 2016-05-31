class AddExceptionToLog < ActiveRecord::Migration
  def change
    add_column :logs, :exception, :text
  end
end
