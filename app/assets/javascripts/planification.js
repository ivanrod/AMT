// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require moment.js
//= require fullcalendar.min.js

/*
$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here

    left:   'title',
    center: '',
    right:  'today prev,next',
    defaultView: 'agendaWeek',
    eventLimit: true, // allow "more" link when too many events
    events: [
    {
      title: 'All Day Event',
      start: '2014-12-04'
    },
    {
      title: 'Long Event',
      start: '2014-12-07',
      end: '2014-12-10'
    },
    {
      title: 'Long Event',
      start: '2014-12-07',
      end: '2014-12-10'
    },
    {
      title: 'Long Event',
      start: '2014-12-07',
      end: '2014-12-10',
      color: "red"
    },
    {
        id: 999,
        title: 'Repeating Event',
        start: '2014-12-09T16:00:00'
    },
    {
        title: 'Event',
        start: '2014-12-09T10:00:00',
        end: '2014-12-09T19:00:00'
    }
    ]

    })

});

*/

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