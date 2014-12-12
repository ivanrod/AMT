// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require moment.js
//= require fullcalendar.min.js


$(document).ready(function() {

    // page is now ready, initialize the calendar...
    $.post('getdeadlines', function(data){
      $('#calendar').fullCalendar({
        // put your options and callbacks here

    left:   'title',
    center: '',
    right:  'today prev,next',
    defaultView: 'agendaWeek',
    eventLimit: true, // allow "more" link when too many events
    events: data

    })
}
      ) 
    

});