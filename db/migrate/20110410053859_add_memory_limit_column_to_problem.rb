class AddMemoryLimitColumnToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :memory_limit, :integer, :default => 32
  end

  def self.down
    remove_column :problems, :memory_limit
  end
end
