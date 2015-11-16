class IncidentTest < ActiveRecord::Base
  belongs_to :incident, dependent: :destroy
  belongs_to :test
end
