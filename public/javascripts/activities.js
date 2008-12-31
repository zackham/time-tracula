var Activities = {
  clock_in: function(id) { this.member_action(id, 'clock_in'); }, 
  
  clock_out: function(id) { this.member_action(id, 'clock_out'); },
  
  unclock: function(id) { this.member_action(id, 'unclock'); },
  
  delete: function(id) { 
    this.activities_body().load(
      '/activities/' + id + '?' + this.opts_qs(), 
      {_method: 'delete'}
    ); 
  },
  
  member_action: function(id, action) {
    this.activities_body().load('/activities/' + id + '/' + action + '?' + this.opts_qs());
  },
  
  activities_body: function() { return $('#activities_list'); },
  
  opts_qs: function() {
    return $('.opts')[0].style.display != 'none' ? 'show_opts=1' : '';
  }
};

$(document).ready(function() { 
  $('#activities form').ajaxForm({
    target: Activities.activities_body(),
    success: function () {
      $('#activity_blurb')[0].value = ''; 
      $('#activity_blurb')[0].focus();
    }});
  
  $('#activities_list tbody[id^=unclocked] > tr > td:first-child').livequery(function() {
    $(this).addClass('clickable')
  
    $(this).bind('click', function() {
      var tmp = $(this).parents('tbody')[0];
      var tbody = /-title$/.test(tmp.id) ? $(tmp).next()[0] : tmp;
      var tbody_title = $(tbody).prev()[0];
      $(tbody).toggle();
      $(tbody_title).toggle();
    });
  });
});