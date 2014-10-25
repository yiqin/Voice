//
//  LeaftaggerScreenManager.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeaftaggerScreenManager : NSObject

// Singlenton Method
+ (void)setScreenSize;
+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;

@end
