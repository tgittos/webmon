class RenameContentTestToTestAndAddType < ActiveRecord::Migration
  def change
    rename_table :content_tests, :tests
    add_column :tests, :type, :string
  end
end
