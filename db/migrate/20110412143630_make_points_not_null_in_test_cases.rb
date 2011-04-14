class MakePointsNotNullInTestCases < ActiveRecord::Migration
  def self.up
    TestCase.where(:points => nil).each do |test_case|
      test_case.points = 10
      test_case.save
    end
    change_column :test_cases, :points, :integer, :null => false, :default => 10
  end

  def self.down
    change_column :test_cases, :points, :integer, :null => true
  end
end
