//
//  LeaftaggerComment.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerComment.h"
#import "YQParse.h"

@implementation LeaftaggerComment

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithYQParseObject:parseObject];
    if (self) {
        
        NSDictionary *createdBy = [self.responseJSON objectForKey:@"createdBy"];
        
        self.betaUserObjectId = [createdBy objectForKey:@"objectId"];
        
        // Takes too much time
        /*
        YQParseQuery *query = [YQParseQuery queryWithClassName:@"YQBetaUser"];
        [query getObjectInBackgroundWithId:betaUserObjectId block:^(YQParseObject *object, NSError *error) {
            if (!error) {
                self.betaUserCreated = [[LeaftaggerBetaUser alloc] initWithYQParseObject:object];
            }
        }];
        */
    }
    return self;
}

@end
