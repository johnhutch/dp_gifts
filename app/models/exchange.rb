class Exchange < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :matchups
  has_many :matches, :through => :matchups

  attr_accessible :description, :name, :state, :summary

  validates_presence_of :name, :summary

  state_machine :initial => :signup do
    after_transition :signup => :matched, :do => :notify_matches
    after_transition :matched => :closed, :do => :notify_closure

    state :signup do
      def state_description
        "This gift exchange is open for signups!"
      end

      def call_to_action
        "Stay tuned! You should received your matchup within a few days."
      end
    end

    state :matched do
      def state_description
        "Signups for this gift exchange are closed. Stay tuned as giftees post their gifts!"
      end

      def call_to_action
        "You have received your match! Go read up on your giftee to figure out what to get them."
      end
    end

    state :closed do
      def state_description
        "This gift exchange is now closed. Check the blog for pictures of some of the awesome gifts people received!"
      end

      def call_to_action
        "This gift exchange is now closed. Have you posted pics of your gift yet?"
      end
    end

    event :match_and_notify do
      transition :signup => :matched
    end

    event :close do
      transition :matched => :closed
    end
  end

  private

  def notify_matches
    match_array = self.users.sort_by { rand }
    match_array.each_with_index {|user, i|
      if i < (match_array.size - 1)
        user.matchup(match_array[i+1], self)
      else
        user.matchup(match_array[0], self)
      end
    }

    Notifier.matched(self).deliver
  end

  def notify_closure
    Notifier.closed(self).deliver
  end

end
