module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def link_to_function(name, js, opts={})
      link_to( name, 'javascript:;', opts.merge({:onclick => js}))
    end
  end
end
