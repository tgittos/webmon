class AddEmailThresholdsToTests < ActiveRecord::Migration
  def change
    add_column :tests, :failure_threshold, :integer
    add_column :tests, :clear_threshold, :integer
  end
end
