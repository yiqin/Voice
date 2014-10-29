//
//  LeaftaggerTapGestureRecognizer.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerTapGestureRecognizer.h"

@implementation LeaftaggerTapGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self) {
        [self setNumberOfTouchesRequired:2];
        [self setNumberOfTapsRequired:1];
    }
    return self;
}

@end
