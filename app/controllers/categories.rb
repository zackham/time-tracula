class Categories < Application
  def create(category)
    @category = Category.create(category)
    redirect resource(:activities)
  end
  
  def activities(id)
    @category = Category.get(id)
    @activities = @category.activities.reject{|a| !a.complete?}
    display @activities
  end
end # Categories
