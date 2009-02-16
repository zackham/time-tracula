class Category
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String

  has n, :activities
  has n, :plans
  
  def to_s
    name
  end
end
