// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery.weekcalendar

$(document).ready(function() {
  $('#calendar').weekCalendar({
    events:[{"id":10182,
      "start":"2014-12-03T12:15:00.000+10:00",
      "end":"2014-12-03T13:15:00.000+10:00",
      "title":"Lunch with Mike"
    }, {
      "id":10182,
      "start":"2014-12-03T14:00:00.000+10:00",
      "end":"2014-12-03T15:00:00.000+10:00",
      "title":"Dev Meeting"
    }]
  });
});