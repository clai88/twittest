class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { maximum: 170, too_long: "Unfortunately, 170 characters is the maximum allowed.  Please shorten your teet."  }, length: { minimum: 1, too_short: "Tweets must be at least one character long."  }

  def time_elapsed
    base = TimeDifference.between(self.updated_at,Time.now)
    case base.in_minutes.to_i
    when 0
      "#{base.in_seconds.to_i}s"
    when 0...60
      "#{base.in_minutes.to_i}m"
    when 60...1440
      "#{base.in_hours.to_i}h"
    when 1440...10_080
      "#{base.in_days.to_i}d"
    else
      Time.now.to_formatted_s(:short)
    end
  end
end
