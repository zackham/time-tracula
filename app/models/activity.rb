class Activity
  include DataMapper::Resource
  
  property :id, Serial

  property :time_in, DateTime
  property :category_id, Integer
  property :time_out, DateTime
  property :blurb, Text

  belongs_to :category
  
  # i'm picky about the sorting so it is somewhat complex and verbose.  i don't know how to accomplish this in SQL so i'm doing it in ruby.
  def self.today
    all(
      :conditions => ['time_in > ? OR time_in IS NULL', Date.today]
    ).sort {|a,b| 
      # clocked out items go on the bottom of the list, sorted descending
      if a.time_out or b.time_out
        if a.time_out && b.time_out
          b.time_in <=> a.time_in 
        else
          a.time_out ? 1 : -1
        end
        
      # unclocked items go in the middle of the list, sorted by id desc
      elsif a.time_in.nil? or b.time_in.nil?
        if a.time_in.nil? && b.time_in.nil?
          b.id <=> a.id
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
