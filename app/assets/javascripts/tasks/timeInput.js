'use strict';

var timeInputButtons = document.getElementsByClassName("time-input-button-plus");
for (var i=0; i<timeInputButtons.length; i++){
	timeInputButtons[i].addEventListener("click", addTime)
};


$(function(){
	$(".time-input-button").click(function() {
		event.preventDefault();
		//console.log(this.parentNode)
		$( ".time-input", this.parentNode.parentNode ).toggle( "blind", 500 );
	});
});

function addTime(e){
	var originalHours = document.getElementById("hours" + e.target.getAttribute("data-input")).getAttribute('data-hours');
	var originalMinutes = document.getElementById("hours" + e.target.getAttribute("data-input")).getAttribute('data-minutes')
	
	var minutes = document.getElementById("minutesInput" + e.target.getAttribute("data-input")).value;
	minutes = parseInt(minutes) + parseInt(originalMinutes);
	

	var hours = document.getElementById("hoursInput" + e.target.getAttribute("data-input")).value;
	hours = parseInt(hours) + parseInt(originalHours);
	

	if (minutes >= 60){
		hours += 1;
		minutes = minutes - 60;
	};

	document.getElementById("hours" + e.target.getAttribute("data-input")).setAttribute('data-minutes', minutes);
	document.getElementById("hours" + e.target.getAttribute("data-input")).setAttribute('data-hours', hours);
	$.post('/add_time', JSON.stringify([hours, minutes, e.target.getAttribute("data-input")]), changeTime(hours, minutes, e));
};

function changeTime(hours, minutes, e){
		document.getElementById("hours" + e.target.getAttribute("data-input")).innerHTML = hours + "h ";
		document.getElementById("hours" + e.target.getAttribute("data-input")).innerHTML += minutes + "m";

		document.getElementById("minutesInput" + e.target.getAttribute("data-input")).value = 0;
		document.getElementById("hoursInput" + e.target.getAttribute("data-input")).value = 0;
}
