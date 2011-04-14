class AddInputAndOutputToTestCases < ActiveRecord::Migration

  # at some point we should zip input and output

  def self.up
    remove_column :test_cases, :data
    add_column :test_cases, :input, :text
    add_column :test_cases, :output, :text
  end

  def self.down
    add_column :test_cases, :data, :binary
    remove_column :test_cases, :input
    remove_column :test_cases, :output
  end

end
