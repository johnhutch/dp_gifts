class Exchange < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_accessible :description, :name, :state, :summary

  validates_presence_of :name, :description, :summary

  state_machine :initial => :signup do
    after_transition :signup => :matched, :do => :match_and_notify
    after_transition :matched => :closed, :do => :open_blog_and_notify

    state :signup, :matched, :closed
  end

  def match_and_notify
    for user in self.users
      user.matchup
    end
  end

  def open_blog_and_notify
    for user in self.users
    end
  end

end
