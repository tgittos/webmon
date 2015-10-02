class AddActiveToContentTest < ActiveRecord::Migration
  def change
    add_column :content_tests, :active, :boolean, default: true
  end
end
