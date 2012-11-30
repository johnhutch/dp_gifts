class Exchange < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_accessible :description, :name, :state, :summary

  validates_presence_of :name, :description, :summary

  state_machine :initial => :signup do
    after_transition :signup => :matched, :do => :match_and_notify
    after_transition :matched => :closed, :do => :open_blog_and_notify

    state :signup do
      def state_description
        "This gift exchange is open for signups!"
      end
    end
    state :matched do
      def state_description
        "Signups for this gift exchange are closed. Stay tuned as giftees post their gifts!"
      end
    end
    state :closed do
      def state_description
        "This gift exchange is now close. Check the blog for pictures of some of the awesome gifts people received!"
      end
    end
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
