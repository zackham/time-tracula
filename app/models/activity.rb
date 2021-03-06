class Activity
  include DataMapper::Resource
  
  property :id, Serial
  
  property :category_id, Integer
  property :time_in, DateTime
  property :time_out, DateTime
  property :blurb, Text

  belongs_to :category
   
  
  def complete?
    time_in && time_out
  end
  
  def started?
    ! time_in.nil?
  end
  
  def in_progress?
    time_in && time_out.nil?
  end
  
  def elapsed
    in_progress? ? (DateTime.now - time_in) : (time_out - time_in)
  end
  
  def elapsed_minutes
    elapsed * 1440.0
  end
  
  def to_s
    blurb
  end
  
  def self.started
    all(:conditions => ['time_in IS NOT NULL'])
  end
  
  def self.completed
    all(:conditions => ['time_in IS NOT NULL AND time_out IS NOT NULL'])
  end
  
  def self.all_on_day(date)
    all(:conditions => ['time_in > ? AND time_in < ?', date, date + 1])
  end
  
  def self.today
    all(:conditions => ['time_in > ? OR time_in IS NULL', Date.today])
  end
  
  # i'm picky about the sorting so it is somewhat complex and verbose.  i don't know how to accomplish this in SQL so i'm doing it in ruby.
  def self.today_sorted
    today.sort {|a,b| 
      # clocked out items go on the bottom of the list, sorted descending
      if a.time_out or b.time_out
        if a.time_out && b.time_out
          b.time_in <=> a.time_in 
        else
          a.time_out ? 1 : -1
        end
        
      # unclocked items go in the middle of the list, sorted by category id asc
      elsif a.time_in.nil? or b.time_in.nil?
        if a.time_in.nil? && b.time_in.nil?
          a.category_id <=> b.category_id
        else
          a.time_in.nil? ? 1 : -1
        end
        
      # clocked in items go on the top, sorted by time in desc
      else
        b.time_in <=> a.time_in
      end
    }
  end
end
