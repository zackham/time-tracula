class Goal
  include DataMapper::Resource
  
  property :id, Serial

  property :duration, Integer
  property :deadline, DateTime
  property :category_id, Integer
  
  belongs_to :category
  
  def self.relevant
    all(:conditions => ['deadline > ?', Time.now])
  end
  
  def duration_hours= hours
    self.duration = hours.to_f * 60
  end
  
  def duration_hours 
    duration / 60.0 if duration
  end
  
  def completion
    category.activities.today.started.inject(0) {|memo, activity| memo + activity.elapsed_minutes }
  end
  
  def completion_hours
    completion / 60.0 if completion
  end
  
  def completion_percentage
    completion / duration.to_f * 100
  end

end
