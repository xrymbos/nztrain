class AddTimeLimitColumnToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :time_limit, :decimal, :default => 1
  end

  def self.down
    remove_column :problems, :time_limit
  end
end
