//
//  YQManager.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LeaftaggerView.h"

#import "LeaftaggerObject.h"
#import "LeaftaggerApp.h"
#import "LeaftaggerPage.h"
#import "LeaftaggerPoint.h"
#import "LeaftaggerComment.h"
#import "LeaftaggerScreenManager.h"

#import "LeaftaggerTapGestureRecognizer.h"


@interface Leaftagger : NSObject

// applicationId is user session token
// apiKey is user app objectId
+ (void)setApplicationId:(NSString*)applicationId apiKey:(NSString*)apiKey;

+ (NSString*)getApplicationId;
+ (NSString*)getApiKey;

+ (void)tagLeafOnViewController:(id)viewController;


@end
