//
//  YO.h
//  YO
//
//  Created by yiqin on 7/26/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YO : NSObject

+ (void) startWithAPIKey: (NSString *) APIKey;

+ (void) sendYO;
+ (void) sendYOToIndividualUser: (NSString *) username;
+ (void) countTotalSubscribers;

@end
