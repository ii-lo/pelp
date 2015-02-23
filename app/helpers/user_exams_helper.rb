module UserExamsHelper
  def time_from_seconds(seconds)
    seconds = seconds.to_i
    min = seconds / 60
    secs = seconds % 60
    secs = secs < 10 ? "0#{secs}" : secs.to_s
    "#{min}:#{secs}"
  end
end
