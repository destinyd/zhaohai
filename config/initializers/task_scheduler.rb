require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new
scheduler.every "1m" do
  Activity.on_job.each do |activity|
    activity.send("#{activity.now_status}!")
  end
end
