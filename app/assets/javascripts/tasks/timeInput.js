'use strict';
/*
var timeInputButtons = document.getElementsByClassName("time-input-button");
for (i=0; i<timeInputButtons.length; i++){
	timeInputButtons[i].addEventListener("click", toggleTimeInput)
};
*/

$(function(){
	$(".time-input-button").click(function() {
		event.preventDefault();
		//console.log(this.parentNode)
		$( ".time-input", this.parentNode.parentNode ).toggle( "blind", 500 );
	});
});