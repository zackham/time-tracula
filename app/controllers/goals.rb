class Goals < Application

  def create(goal)
    @goal = Goal.create(goal.merge(:deadline => (Date.today + 1)))
    show_all
  end
  
  def destroy(id)
    Goal.get(id).destroy
    show_all
  end
  
  private
    def set_goals
      @goals = Goal.relevant
    end
    
    def show_all      
      if request.xhr?       
        set_goals
        partial :list
      end
    end
end # Goals
