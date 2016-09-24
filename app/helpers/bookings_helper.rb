module BookingsHelper
  def options_for_time_select
    hour = Array.new
    for $h in 8..21 do
      for $m in ['00','30'] do
        hour.push [$h.to_s + "h" + $m.to_s, "%02d" % $h + ":" + $m + ":00"]
      end
    end
    hour
    end
end
