require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a category exists" do
  Category.all.destroy!
  request(resource(:categories), :method => "POST", 
    :params => { :category => { :id => nil }})
end

describe "resource(:categories)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:categories))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of categories" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a category exists" do
    before(:each) do
      @response = request(resource(:categories))
    end
    
    it "has a list of categories" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Category.all.destroy!
      @response = request(resource(:categories), :method => "POST", 
        :params => { :category => { :id => nil }})
    end
    
    it "redirects to resource(:categories)" do
      @response.should redirect_to(resource(Category.first), :message => {:notice => "category was successfully created"})
    end
    
  end
end

describe "resource(@category)" do 
  describe "a successful DELETE", :given => "a category exists" do
     before(:each) do
       @response = request(resource(Category.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:categories))
     end

   end
end

describe "resource(:categories, :new)" do
  before(:each) do
    @response = request(resource(:categories, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@category, :edit)", :given => "a category exists" do
  before(:each) do
    @response = request(resource(Category.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@category)", :given => "a category exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Category.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @category = Category.first
      @response = request(resource(@category), :method => "PUT", 
        :params => { :category => {:id => @category.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@category))
    end
  end
  
end

