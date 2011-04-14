class ChangeWeightToPoints < ActiveRecord::Migration
  def self.up
    remove_column :test_cases, :weight
    add_column :test_cases, :points, :integer
  end

  def self.down
    remove_column :test_cases, :points
    add_column :test_cases, :weight, :integer
  end
end
