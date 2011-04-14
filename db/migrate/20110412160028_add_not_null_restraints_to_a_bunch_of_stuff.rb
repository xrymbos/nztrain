class AddNotNullRestraintsToABunchOfStuff < ActiveRecord::Migration
  def self.up
    Submission.update_all ["problem_id = ?", 1]
    Submission.update_all ["user_id = ?", 1]
    TestCase.update_all ["problem_id = ?", 1]

    change_column :problems, :time_limit, :decimal, :null => false
    change_column :problems, :memory_limit, :integer, :null => false
    change_column :problems, :input, :string, :null => false
    change_column :problems, :output, :string, :null => false
    change_column :problems, :statement, :text, :null => false
    change_column :problems, :title, :string, :null => false

    change_column :submissions, :source, :text, :null => false
    change_column :submissions, :language, :string, :null => false
    change_column :submissions, :problem_id, :integer, :null => false
    change_column :submissions, :user_id, :integer, :null => false

    change_column :test_cases, :problem_id, :integer, :null => false
    change_column :test_cases, :input, :text, :null => false
    change_column :test_cases, :output, :text, :null => false
  end

  def self.down
    change_column :problems, :time_limit, :decimal, :null => true
    change_column :problems, :memory_limit, :integer, :null => true
    change_column :problems, :input, :string, :null => true
    change_column :problems, :output, :string, :null => true
    change_column :problems, :statement, :text, :null => true
    change_column :problems, :title, :string, :null => true

    change_column :submissions, :source, :text, :null => true
    change_column :submissions, :language, :string, :null => true
    change_column :submissions, :problem_id, :integer, :null => true
    change_column :submissions, :user_id, :integer, :null => true

    change_column :test_cases, :problem_id, :integer, :null => true
    change_column :test_cases, :input, :text, :null => true
    change_column :test_cases, :output, :text, :null => true
  end
end
