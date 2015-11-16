class IncidentTest < ActiveRecord::Base
  belongs_to :incident
  belongs_to :test
end
