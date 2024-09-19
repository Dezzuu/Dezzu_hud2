$(document).ready(function() {

    
    window.addEventListener('message', function(event) {
        let action = event.data.action;

        if (action === "updateHud") {
            
            updateStats('.hearth', event.data.health); 
            updateStats('.food', event.data.hunger); 
            updateStats('.thirst', event.data.thirst); 
            updateStats('.voice', event.data.voiceMode, event.data.talking);

            
            if (event.data.inVeh) {
                $('.car-main').fadeIn(700);
                $('.mph, .kierunek, .street').stop(true, true).fadeIn(400).css('transform', 'translateY(0)'); 
                $('.mph').text(Math.round(event.data.speed) + ' MPH'); 
                $('.kierunek').text(event.data.compass);
                let road = event.data.road || "Unknown"; 
                $('.street').text(road);
            } else {
                $('.mph, .kierunek, .street, .car-main').fadeOut(700);
            }

            
            if (event.data.oxygen !== null && event.data.oxygen !== undefined && event.data.oxygen < 100) {
                $('.oxygen').fadeIn(400); 
                updateStats('.oxygen', event.data.oxygen); 
            } else {
                $('.oxygen').fadeOut(400); 
            }
        }

    });

    function updateStats(selector, value) {
        $(selector).css('background', `linear-gradient(180deg, #1E2A32 0%, #1E2A32 ${100 - value}%, #0099FF ${100 - value}%, #0099FF 100%)`);
    }
});





