class RenameContentTestIdToTestIdForTestResult < ActiveRecord::Migration
  def change
    rename_column :test_results, :content_test_id, :test_id
  end
end
