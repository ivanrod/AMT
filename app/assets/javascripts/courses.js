// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require tasks/timeInput.js
//= require flipclock.min.js

$(function(){
    $('#course_start_date').datepicker({ dateFormat: 'D, dd M yy' });
    $('#course_end_date').datepicker({ dateFormat: 'D, dd M yy' });

    $(".pomodoro-button").click(function() {
        event.preventDefault();
        //console.log(this.parentNode)
        $( ".pomodoro-div", this.parentNode.parentNode ).toggle( "blind", 500 );

        var clock;

        clock = $('.clock', this.parentNode.parentNode).FlipClock({
            clockFace: 'MinuteCounter',
            autoStart: false,
            callbacks: {
                stop: function() {
                    $('.message').html('The clock has stopped!')
                }
            }
        });
        
        var clockTime = 1800;
        clock.setTime(clockTime);
        clock.setCountdown(true);
        //clock.start();

        $('.range-slider', this.parentNode.parentNode).on('change.fndtn.slider', function(){
          // do something when the value changes
        clockTime = $('.range-slider', this.parentNode.parentNode).attr('data-slider');
        clock.setTime(clockTime);
        });

        });



});
