({
	doInit : function(component, event, helper) {
	var action = component.get("c.getCurrentUser");
        action.setCallback(this, function(response) {
            var user = response.getReturnValue();
            var lastLogin = user.LastLoginDate;
            var keyHit = parseInt(component.get("v.keyHit"));
			helper.timeHelper(component, lastLogin);
            helper.wordTrackHelper(component, event, keyHit);
        });
        $A.enqueueAction(action);
	},
})
