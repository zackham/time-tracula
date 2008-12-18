class Categories < Application
  def create(category)
    @category = Category.create(category)
    redirect resource(:activities)
  end
end # Categories
