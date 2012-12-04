class Matchup < ActiveRecord::Base
  attr_accessible :exchange_id, :match_id, :user_id

  belongs_to :exchange
  belongs_to :user
  belongs_to :match, :class_name => 'User'

end
