class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :body, length: { maximum: 170, too_long: "Unfortunately, 170 characters is the maximum allowed.  Please shorten your teet"  }

  def time
    a = self.updated_at
    b = Time.now
    # diff = TimeDifference.between(a,b).in_hours.to_i
    diff = TimeDifference.between(a,b).in_minutes.to_i
    base = TimeDifference.between(a,b)

    case diff
    when 0
      time = TimeDifference.between(a,b).in_seconds.to_i
      "#{time}s"
    when 0...60
      diff
      "#{diff}m"
    when 60...1440
      time = TimeDifference.between(a,b).in_hours.to_i
      "#{time}h"
    when 1440...10_080
      time = TimeDifference.between(a,b).in_days.to_i
      "#{time}d"
    when 10_080...43_200
      time = TimeDifference.between(a,b).in_weeks.to_i
      "#{time}w"
    else
      a.to_formatted_s(:short)
    end
  end
end
