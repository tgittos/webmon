class DropSiteHealths < ActiveRecord::Migration
  def change
    drop_table :site_healths
  end
end
