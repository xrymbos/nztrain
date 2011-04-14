class AddProblemIdToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :problem_id, :integer
    add_column :submissions, :user_id, :integer
  end

  def self.down
    remove_column :submissions, :problem_id
    remove_column :submissions, :user_id
  end
end
