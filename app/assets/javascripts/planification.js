// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require moment.js
//= require fullcalendar.min.js

$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here

    left:   'title',
    center: '',
    right:  'today prev,next',
    defaultView: 'basicWeek',
    events: [
    {
      title: 'All Day Event',
      start: '2014-12-04'
    },
    {
      title: 'Long Event',
      start: '2014-12-07',
      end: '2014-12-10'
    }
    ]

    })

});