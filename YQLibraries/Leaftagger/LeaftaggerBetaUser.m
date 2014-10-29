//
//  LeaftaggerBetaUser.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerBetaUser.h"
#import "YQParse.h"

@implementation LeaftaggerBetaUser

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithYQParseObject:parseObject];
    if (self) {
        self.username = [self.responseJSON objectForKey:@"username"];
        self.email = [self.responseJSON objectForKey:@"email"];
    }
    return self;
}

@end
