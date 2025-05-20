class WeeklyDigestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    date = 1.week.ago
    User.all.each do |user|
      RecipeMailer.with(user: user, date: date).recent.deliver_later
    end
  end
end
