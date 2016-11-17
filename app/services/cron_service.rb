require 'rubygems'
require 'rufus/scheduler'
class CronService

  def self.start
    scheduler = Rufus::Scheduler.new
    ahora = DateTime.now
    ago = ahora - 10.minutes
    scheduler.every '11m' do
      basket = Basket.where("created_at < ?", ago)
      basket.destroy_all
    end
  end
  
end
