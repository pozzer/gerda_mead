class AddUniqueIndexToSystemToken < ActiveRecord::Migration
  def change
    add_index :systems, :token, unique: true
  end
end
