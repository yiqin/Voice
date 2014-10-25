//
//  LeaftaggerObject.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerObject.h"

@implementation LeaftaggerObject

- (instancetype)initWithYQParseObject:(YQParseObject *)parseObject
{
    self = [super initWithClassName:parseObject.parseClassName];
    if (self) {
        // Copy the parseObject behaviour.
        self.objectId = parseObject.objectId;
        self.createdAt = parseObject.createdAt;
        self.updatedAt = parseObject.updatedAt;
        self.responseJSON = parseObject.responseJSON;
        
        self.text = [parseObject.responseJSON objectForKey:@"text"];
        
    }
    return self;
}

@end
