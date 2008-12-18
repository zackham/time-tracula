class Application < Merb::Controller
  before :set_js_includes
  
  def set_js_includes
    @js_includes = ['jquery.js', 'livequery.js', 'form.js']
  end
end