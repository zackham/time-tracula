class Goal
  include DataMapper::Resource
  
  property :id, Serial

  property :duration, Integer
  property :deadline, DateTime
  property :category_id, Integer
  
  belongs_to :category
  
  def self.relevant
    all(:conditions => ['deadline > ?', DateTime.now])
  end
  
  def self.all_on_day(date)
    all(:conditions => ['deadline > ? AND deadline < ?', date + 1, date + 2])
  end
  
  def duration_hours= hours
    self.duration = hours.to_f * 60
  end
  
  def duration_hours 
    duration / 60.0 if duration
  end
  
  def activity_date
    @activity_date ||= Date.new(deadline.year, deadline.month, deadline.day - 1)
  end
  
  def completion
    category.activities.all_on_day(activity_date).started.inject(0) {|memo, activity| memo + activity.elapsed_minutes }
  end
  
  def clocked_out_completion
    category.activities.all_on_day(activity_date).completed.inject(0) {|memo, activity| memo + activity.elapsed_minutes }
  end
  
  def completion_hours
    completion / 60.0 if completion
  end
  
  def completion_percentage
    completion / duration.to_f * 100
  end

end
