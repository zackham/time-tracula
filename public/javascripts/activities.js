var Activities = {
  clock_in: function(id) { this.member_action(id, 'clock_in'); }, 
  
  clock_out: function(id) { this.member_action(id, 'clock_out'); Goals.goals_body().load('/goals'); },
  
  unclock: function(id) { this.member_action(id, 'unclock'); },
  
  remove: function(id) { 
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

var Plans = {
  remove: function(id) { 
    this.plans_body().load(
      '/plans/' + id, 
      {_method: 'delete'}
    ); 
  },

  plans_body: function() { return $('#plans_list'); }
};

var Goals = {
  remove: function(id) { 
    this.goals_body().load(
      '/goals/' + id, 
      {_method: 'delete'}
    ); 
  },

  goals_body: function() { return $('#goals_list'); }
};

$(document).ready(function() { 
  // ready activities form
  $('#activities form').ajaxForm({
    target: Activities.activities_body(),
    success: function () {
      $('#activity_blurb')[0].value = ''; 
      $('#activity_blurb')[0].focus();
    }});
  
  // ready plans form
  $('#plan-form form').ajaxForm({
    target: Plans.plans_body(),
    success: function () {
      $('#plan_blurb')[0].value = ''; 
      $('#plan_blurb')[0].focus();
    }});
  
  // ready goals form
  $('#goal-form form').ajaxForm({
    target: Goals.goals_body(),
    success: function () {
      $('#goal_duration_hours')[0].value = ''; 
    }});
  
  // collapse/expand unclocked items
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
  
  
  $('.activity-blurb').livequery(function() {
    $(this).bind('mouseover', function() {
      $(this).addClass('editable');
    });
    
    $(this).bind('mouseout', function() {
      $(this).removeClass('editable');
    });
    
    $(this).bind('click', function() {
      alert('click');
      var input = $('<input type="text" name="activity[blurb]"/>').attr('value', $(this).text());
      $(this).html(input);
      $(this).mouseout().unbind('click').unbind('mouseover').unbind('mouseout');
      input.focus();
    });
  });
});