({
	timeHelper : function(component, lastLogin) {
    	var timeHours = new Date(lastLogin).getHours();
        var timeMinutes = new Date(lastLogin).getMinutes();
        var nowHours = new Date().getHours();
        var nowMinutes = new Date().getMinutes();
        var diffHours = nowHours - timeHours;
        var diffMinutes = Math.abs(nowMinutes - timeMinutes);
                       
        var message = "You have been busy for " + diffHours + " hour(s) and " + diffMinutes + " minute(s).";
       
        if (diffHours >= 2)
            message += "\n Consider taking a minute to stretch if you haven't already.";
        if (diffHours >= 4)
            message += "\n Consider taking a small break if you haven't already.";
		component.set("v.message", message);      
	},
    
    wordTrackHelper : function(component, event, keyHit) {
        var startTime;
    	window.addEventListener("keydown", function(event) {
            if (keyHit == 0)
            {
            startTime = new Date();
            component.set("v.startTime", startTime);
            keyHit += 1;
            }
            else
            {
            keyHit += 1; 
            component.set("v.keyHit", keyHit.toString());
            var endTime = new Date();
            var elapsedTime = (endTime - startTime) / 1000;
            var formatElapsed = Math.floor(elapsedTime) / 100;
            var wpm = (keyHit / 6) / formatElapsed;
            component.set("v.wordCount", Math.floor(wpm));
            }
        });
    }
})
