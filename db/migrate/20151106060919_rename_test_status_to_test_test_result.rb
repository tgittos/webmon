class RenameTestStatusToTestTestResult < ActiveRecord::Migration
  def change
    rename_table :test_statuses, :test_results
  end
end
