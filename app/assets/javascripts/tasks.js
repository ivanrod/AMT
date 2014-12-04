// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require tasks/timeInput.js
//= require jquery.datetimepicker.js


$(function(){
	//$('#task_deadline').datepicker({ dateFormat: 'D, dd M yy' });
	$('#task_deadline').datetimepicker({ 
		formatDate: 'd.m.Y'
	});
});