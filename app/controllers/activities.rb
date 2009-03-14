class Activities < Application
  def index
    @js_includes << 'activities.js'
    
    set_activities
    
    
    # goal orientedness 
    
    # for each day, go back 2 weeks
    @goal_orientedness = []
    for i in (0..14).to_a.reverse
      go_hash = {}
      go_hash[:time_clocked] = Activity.all_on_day(Date.today - i).completed.inject(0) {|m,a| m + a.elapsed_minutes}
      go_hash[:time_clocked_in_goals] = Goal.all_on_day(Date.today - i).inject(0) {|m,g| m + g.clocked_out_completion}
      go_hash[:goals_duration] = Goal.all_on_day(Date.today - i).inject(0) {|m,g| m + g.duration}
      @goal_orientedness << go_hash
    end
    
    
    
    
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
    def set_activities
      activities = Activity.today_sorted
      
      # determine if two activities belong in same group
      same_group = proc { |a, b|
        a.complete? && b.complete? || 
          a.in_progress? && b.in_progress? ||
          !a.started? && !b.started? && a.category_id == b.category_id
      }
      
      # grouping activities into clocked in, unclocked groups of categories, and clocked out
      @activities = []
      for activity in activities
        ( !@activities.empty? && same_group.call(@activities.last.last, activity) ) ? @activities.last << activity : @activities << [activity]
      end
      
      # set plans too
      @plans = Plan.relevant
      
      # set goals as well!
      @goals = Goal.relevant
    end
    
    def show_all      
      if request.xhr?       
        set_activities 
        partial :activities
      else
        redirect resource(:activities)
      end
    end

end # Activities
