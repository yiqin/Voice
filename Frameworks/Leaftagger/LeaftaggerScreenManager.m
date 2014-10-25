//
//  LeaftaggerScreenManager.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "LeaftaggerScreenManager.h"

@interface LeaftaggerScreenManager ()

@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;

@end

@implementation LeaftaggerScreenManager

+ (instancetype)sharedManager
{
    static LeaftaggerScreenManager *sharedYQManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedYQManager = [[self alloc] init];
    });
    return sharedYQManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        _screenWidth = screenRect.size.width;
        _screenHeight = screenRect.size.height;
    }
    return self;
}

+ (void)setScreenSize
{
    LeaftaggerScreenManager *shared = [LeaftaggerScreenManager sharedManager];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    shared.screenWidth = screenRect.size.width;
    shared.screenHeight = screenRect.size.height;
}

+ (CGFloat)getScreenWidth
{
    LeaftaggerScreenManager *shared = [LeaftaggerScreenManager sharedManager];
    return shared.screenWidth;
}

+ (CGFloat)getScreenHeight
{
    LeaftaggerScreenManager *shared = [LeaftaggerScreenManager sharedManager];
    return shared.screenHeight;
}

@end
