
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


Parse.Cloud.define("verifyPhoneNumber", function(request, response) {
    var user = Parse.User.current();
    var verificationCode = user.get("phoneVerificationCode");
    if (verificationCode == request.params.phoneVerificationCode) {

        var user1 = Parse.User.current();
        user1.set("phoneVerified", true);
        user1.set("phoneNumber", request.params.phoneNumber);
        
        user1.save();

        response.success("Success");
    } else {
        response.error("Invalid verification code.");
    }
});

Parse.Cloud.define("sendVerificationCode", function(request, response) {
    var verificationCode = Math.floor(Math.random()*9999);
    var user = Parse.User.current();
    user.set("phoneVerified", false);
    user.set("phoneVerificationCode", verificationCode);
    user.set("phoneNumber", request.params.phoneNumber);
    user.save();
    
    var twilio = require('twilio')('AC840912e124927b5100895bc5b9a67f64', 'f83f5ef557fe90f1b1b4c6cc4d569d5c');
    twilio.sendSms({
        From: "+13177080548",
        To: request.params.phoneNumber,
        Body: "From Voice: your verification code is " + verificationCode + "."
    }, function(err, responseData) { 
        if (err) {
          response.error(err);
        } else { 
          response.success("Success");
        }
    });
});