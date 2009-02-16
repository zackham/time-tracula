class Plans < Application
  def index
    set_plans
    display @activities
  end
  
  def create(plan)
    @plan = Plan.create(plan.merge(:starts_at => Time.now, :repeat => 1, :complete_by => (Date.today + 1)))
    show_all
  end
  
  def destroy(id)
    Plan.get(id).destroy
    show_all
  end
  
  private
    def set_plans
      @plans = Plan.relevant
    end
    
    def show_all      
      if request.xhr?       
        set_plans 
        partial :list
      else
        redirect resource(:plans)
      end
    end
end # Plans
