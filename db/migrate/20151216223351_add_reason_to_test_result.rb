class AddReasonToTestResult < ActiveRecord::Migration
  def change
    add_column :test_results, :reason, :string
  end
end
