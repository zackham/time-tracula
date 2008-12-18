class Activities < Application
  def index
    @js_includes << 'activities.js'
    
    @activities = Activity.today
    display @activities
  end
  
  def clock_in(id)
    Activity.get(id).update_attributes(:time_in => Time.now)
    show_all
  end
  
  def clock_out(id)
    Activity.get(id).update_attributes(:time_out => Time.now)
    show_all
  end
  
  def unclock(id)
    activity = Activity.get(id)
    activity.update_attributes( (activity.time_out ? :time_out : :time_in) => nil )
    show_all
  end

  def create(activity, clock_in = nil)
    @activity = Activity.create( activity.merge(clock_in ? {:time_in => Time.now} : {}) )
    show_all
  end

  def destroy(id)
    Activity.get(id).destroy
    show_all
  end
  
  private
    def show_all
      if request.xhr?
        @activities = Activity.today
        partial :activities
      else
        redirect resource(:activities)
      end
    end

end # Activities
