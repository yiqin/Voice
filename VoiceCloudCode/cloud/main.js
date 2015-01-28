
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
    
    // Test
	var twilio = require('twilio')('AC2496f56a7f2cb2785dd9e736ae990e23', '5922590783110b6493f8bc9f86bf3d20');
	// Product
    // var twilio = require('twilio')('AC840912e124927b5100895bc5b9a67f64', 'f83f5ef557fe90f1b1b4c6cc4d569d5c');
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


var Image = require("parse-image");
 
Parse.Cloud.beforeSave("StreetDetailImage", function(request, response) {
  var streetDetailImage = request.object;
 
  Parse.Cloud.httpRequest({
    url: streetDetailImage.get("image").url()
 
  }).then(function(response) {
    var image = new Image();
    return image.setData(response.buffer);
 
  }).then(function(image) {
    
    var ratio = image.width()/image.height();
    streetDetailImage.set("ratio", ratio);
    streetDetailImage.set("imageHeight", 100);

  }).then(function(result) {
    response.success();
  }, function(error) {
    response.error(error);
  });
});

Parse.Cloud.beforeSave("StreetDetailImageBeta", function(request, response) {
  var streetDetailImage = request.object;
 
  Parse.Cloud.httpRequest({
    url: streetDetailImage.get("image").url()
 
  }).then(function(response) {
    var image = new Image();
    return image.setData(response.buffer);
 
  }).then(function(image) {
    
    var ratio = image.width()/image.height();
    streetDetailImage.set("ratio", ratio);
    streetDetailImage.set("imageHeight", 100);

  }).then(function(result) {
    response.success();
  }, function(error) {
    response.error(error);
  });
});


