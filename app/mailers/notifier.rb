class Notifier < ActionMailer::Base
  default from: Settings.admin_user.email

  def matched(exchange)
    @url = dashboard_url
    mail(:to => Settings.admin_user.email, :bcc => exchange.users.map(&:email), :subject => "Come check out your DP Gifts Match!")
  end

  def closed(exchange)
    @url = dashboard_url
    @name = exchange.name
    mail(:to => Settings.admin_user.email, :bcc => exchange.users.map(&:email), :subject => "Come post your #{exchange.name} gift!")
  end
end
