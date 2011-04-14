class AddTitleToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :title, :string,
               :null => false, :default => "Untitled Group"
  end

  def self.down
    remove_column :groups, :title
  end
end
