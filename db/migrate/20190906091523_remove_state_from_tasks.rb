class RemoveStateFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :state, :string
  end
end
