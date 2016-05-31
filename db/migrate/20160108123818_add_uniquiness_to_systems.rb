class AddUniquinessToSystems < ActiveRecord::Migration
  def change
    change_column :systems, :token, :string, unique: true
  end
end
