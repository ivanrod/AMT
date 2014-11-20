// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require tasks/timeInput.js

$(function(){
	$('#course_start_date').datepicker({ dateFormat: 'D, dd M yy' });
	$('#course_end_date').datepicker({ dateFormat: 'D, dd M yy' });
});