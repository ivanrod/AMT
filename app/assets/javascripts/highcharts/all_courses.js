'use strict';

$(function () { 
	$.post('/setChart', 
		document.getElementById("container").getAttribute("data-ud"),
		function(chartData){
	    $('#container').highcharts({
	        chart: {
	            type: 'spline'
	        },
	        title: {
	            text: 'Tiempo dedicado a los cursos'
	        },
	        subtitle: {
	            text: 'Horas dedicadas'
	        },
	        xAxis: {
	            type: 'datetime',
	            dateTimeLabelFormats: { // don't display the dummy year
	                month: '%e. %b',
	                year: '%b'
	            },
	            title: {
	                text: 'Días'
	            }
	        },
	        yAxis: {
	            title: {
	                text: 'Horas'
	            },
	            min: 0
	        },
	        tooltip: {
	            headerFormat: '<b>{series.name}</b><br>',
	            pointFormat: '{point.x:%e. %b}: {point.y:.2f} h'
	        },

	        series: chartData
	    })
	});
});