// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require tasks/timeInput.js
//= require flipclock.min.js

$(function(){
    $('#course_start_date').datepicker({ dateFormat: 'D, dd M yy' });
    $('#course_end_date').datepicker({ dateFormat: 'D, dd M yy' });
  
    $(".pomodoro-button").click(function(e) {
        
        e.preventDefault();
        //console.log(this.parentNode)
        $( ".pomodoro-div", this.parentNode.parentNode ).toggle( "blind", 500 );
        
        var clock;

        clock = $('.clock', this.parentNode.parentNode).FlipClock({
            targetDiv: this.parentNode.parentNode,
            targetId: this.getAttribute("data-input"),
            clockFace: 'MinuteCounter',
            autoStart: false,
            callbacks: {
                stop: function() {
                    //$('.message').html('The clock has stopped!' + (clockTime - clock.getTime())/60 + "minuts")
                    $('.message').html('The clock has stopped!' + (clock.getTime()))
                    if (clock.getTime() == 0 && event == undefined){
                        console.log(clock.targetDiv.children[0].children[3].getAttribute("data-minutes"));
                        var hours = parseInt(clock.targetDiv.children[0].children[3].getAttribute("data-hours"));
                        var minuts = parseInt(clock.targetDiv.children[0].children[3].getAttribute("data-minutes"));
                        minuts += parseInt((clockTime - clock.getTime())/60);
                        if (minuts >= 60){
                            hours += 1;
                            minuts = minuts - 60;
                        };
                        var pomodoroHours = 0;
                        var pomodoroMinutes = (clockTime - clock.getTime())/60;
                        clock.targetDiv.children[0].children[3].innerHTML = hours + " h" + minuts + " m";
                        clock.targetDiv.children[0].children[3].setAttribute("data-hours", hours);
                        clock.targetDiv.children[0].children[3].setAttribute("data-minutes", minuts);

                        $.post('/add_time', JSON.stringify([parseInt(hours), parseInt(minuts), clock.targetId, pomodoroHours, pomodoroMinutes, 'current']));
                    }
                },
                start: function() {
                    $('.message').html('The clock has started!' + clock.getTime())
                },
                interval: function() {
                    if (clock.getTime() === 54){
                        console.log("Hey!")
                    }
                }
            }
        });
        
        function setTimeButton(){
            
        }

        var clockTime = 1800;
        clock.setTime(clockTime);
        clock.setCountdown(true);
        //clock.start();

        $('.range-slider', this.parentNode.parentNode).on('change.fndtn.slider', function(){
          // do something when the value changes
        clockTime = $('.range-slider', this.parentNode.parentNode).attr('data-slider');
        clock.setTime(clockTime);
        });

        $('.button.success', this.parentNode.parentNode).click(function() {
            $('.button.success', this.parentNode.parentNode).hide();
            $('.button.alert', this.parentNode.parentNode).hide();
            $('.button.info', this.parentNode.parentNode).show();
            $('.range-slider', this.parentNode.parentNode).hide();
            event.preventDefault();
            clock.start();
        });

        $('.button.info', this.parentNode.parentNode).click(function() {
            event.preventDefault(event);
            $('.button.info', this.parentNode.parentNode).hide();
            $('.button.success', this.parentNode.parentNode).show();
            $('.button.alert', this.parentNode.parentNode).show();
            //$('.range-slider', this.parentNode.parentNode).show();
            clock.stop();
        });

        $('.button.alert', this.parentNode.parentNode).click(function() {
            event.preventDefault(event);
            $('.button.info', this.parentNode.parentNode).hide();
            $('.button.success', this.parentNode.parentNode).show();
            $('.button.alert', this.parentNode.parentNode).hide();
            $('.range-slider', this.parentNode.parentNode).show();
            //$('.range-slider', this.parentNode.parentNode).show();
            clockTime = clock.getTime();
            clock.stop();
            
        });
        
        $(document).foundation('reflow');

    });





});
