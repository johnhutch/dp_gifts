class Exchange < ActiveRecord::Base
  attr_accessible :description, :name, :state, :summary
end
