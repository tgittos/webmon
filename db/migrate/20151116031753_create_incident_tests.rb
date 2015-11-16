class CreateIncidentTests < ActiveRecord::Migration
  def change
    create_table :incident_tests do |t|
      t.references :incident
      t.references :test

      t.timestamps null: false
    end
  end
end
