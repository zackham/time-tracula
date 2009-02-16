class Plan
  include DataMapper::Resource
  
  property :id, Serial

  property :duration, Integer
  property :starts_at, DateTime
  property :repeat, Integer
  property :category_id, Integer
  property :complete_by, DateTime
  property :blurb, Text
  
  belongs_to :category

  def self.relevant
    all
  end
end
