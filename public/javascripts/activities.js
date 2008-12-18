var Activities = {
  clock_in: function(id) { this.member_action(id, 'clock_in'); }, 
  
  clock_out: function(id) { this.member_action(id, 'clock_out'); },
  
  unclock: function(id) { this.member_action(id, 'unclock'); },
  
  delete: function(id) { 
    this.activities_tbody().load(
      '/activities/' + id + '?' + this.opts_qs(), 
      {_method: 'delete'}
    ); 
  },
  
  member_action: function(id, action) {
    this.activities_tbody().load('/activities/' + id + '/' + action + '?' + this.opts_qs());
  },
  
  activities_tbody: function() { return $('table#activities tbody:first'); },
  
  opts_qs: function() {
    return $('.opts')[0].style.display != 'none' ? 'show_opts=1' : '';
  }
};

$(document).ready(function() { 
  $('#activities form').ajaxForm({
    target: Activities.activities_tbody(),
    success: function () {
      $('#activity_blurb')[0].value = ''; 
      $('#activity_blurb')[0].focus();
    }});
});