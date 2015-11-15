class AddValueToTestResults < ActiveRecord::Migration
  def change
    add_column :test_results, :value, :string
  end
end
