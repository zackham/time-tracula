require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a activity exists" do
  Activity.all.destroy!
  request(resource(:activities), :method => "POST", 
    :params => { :activity => { :id => nil }})
end

describe "resource(:activities)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:activities))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of activities" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a activity exists" do
    before(:each) do
      @response = request(resource(:activities))
    end
    
    it "has a list of activities" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Activity.all.destroy!
      @response = request(resource(:activities), :method => "POST", 
        :params => { :activity => { :id => nil }})
    end
    
    it "redirects to resource(:activities)" do
      @response.should redirect_to(resource(Activity.first), :message => {:notice => "activity was successfully created"})
    end
    
  end
end

describe "resource(@activity)" do 
  describe "a successful DELETE", :given => "a activity exists" do
     before(:each) do
       @response = request(resource(Activity.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:activities))
     end

   end
end

describe "resource(:activities, :new)" do
  before(:each) do
    @response = request(resource(:activities, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@activity, :edit)", :given => "a activity exists" do
  before(:each) do
    @response = request(resource(Activity.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@activity)", :given => "a activity exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Activity.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @activity = Activity.first
      @response = request(resource(@activity), :method => "PUT", 
        :params => { :activity => {:id => @activity.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@activity))
    end
  end
  
end

