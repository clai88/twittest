class Tweet < ActiveRecord::Base
  belongs_to :user

  def time
    a = self.updated_at
    b = Time.now
    diff = TimeDifference.between(a,b).in_hours.to_i
    diff_min = TimeDifference.between(a,b).in_minutes.to_i

    case diff
    when 0
      if diff_min == 0
        time = TimeDifference.between(a,b).in_seconds.to_i
        "#{time}s"
      else
        diff_min
        "#{diff_min}m"
      end
    when 0...24
      "#{diff}h"
    when 24...168
      time = TimeDifference.between(a,b).in_weeks.to_i
      "#{time}w"
    else
      a.to_formatted_s(:short)
    end
  end

end
